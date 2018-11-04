import UIKit
import Then
import SnapKit
import RxDataSources
import ohMyPostBase
import RxSwift

class PostsViewController: UIViewController {

    private let viewModel: PostViewModel
    private let disposeBag = DisposeBag()
    fileprivate let data = Variable<[Post]>([])
    
    fileprivate var tableView: UITableView! {
        didSet {
            self.configureTableView()
        }
    }
    
    init() {
        let model = PostModel(api: OMPRepository())
        self.viewModel = PostViewModel(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Posts"
        self.view.do {
            $0.backgroundColor = .lightGrayBG
        }
        
        let _ = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil).then {
            $0.tintColor = .turquoiseBlue
            self.navigationItem.rightBarButtonItem = $0
        }
        
        self.tableView = UITableView(frame: .zero, style: .grouped).then {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            $0.rowHeight = 120
            $0.backgroundColor = .lightGrayBG
            $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.rx.getPosts()
            .subscribe(onNext: { [weak self] posts in
                self?.data.value = posts
            })
            .disposed(by: self.disposeBag)
    }
    
    private func configureTableView() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionOfPosts>(configureCell: { (_, tv: UITableView, ip: IndexPath, item: Post) -> UITableViewCell in
            guard let cell = tv.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: ip) as? PostTableViewCell else {
                return UITableViewCell(frame: .zero)
            }
            return cell.then {
                $0.set(data: item)
            }
        })
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        
        self.data.asObservable()
            .map { [SectionOfPosts(header: "Initial", items: $0)] }
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        let _ = self.tableView.rx.setDelegate(self)
        
        self.tableView.rx.modelDeleted(Post.self)
            .subscribe { [weak self] event in
                self?.data.value = self?.data.value.filter { event.element != $0 } ?? []
            }
            .disposed(by: disposeBag)
    }

}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .destructive, title: "DELETE") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
    
        return [deleteButton]
    }
}
