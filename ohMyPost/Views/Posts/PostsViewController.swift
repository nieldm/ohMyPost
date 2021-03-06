import UIKit
import Then
import SnapKit
import RxDataSources
import ohMyPostBase
import RxSwift
import RxCocoa
import CoreData

enum PostSegmentValue: Int {
    case all = 0, favorite
}

class PostsViewController: UIViewController {

    private let viewModel: PostViewModel
    private let disposeBag = DisposeBag()
    fileprivate let data = BehaviorRelay<[Post]>(value: [])
    private lazy var segmentController = UISegmentedControl(frame: .zero)
    private lazy var deleteAllButton = UIButton(frame: .zero)
    private lazy var noResults = UILabel(frame: .zero)
    
    fileprivate var tableView: UITableView! {
        didSet {
            self.configureTableView()
        }
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        let model = PostModel(api:
            OMPRepository(mocked: false)
        )
        self.viewModel = PostViewModel(
            model: model,
            managedObjectContext: managedObjectContext
        )
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
        
        UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil).do {
            $0.tintColor = .turquoiseBlue
            self.navigationItem.rightBarButtonItem = $0
            $0.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] in
                    self?.reloadPosts()
                })
                .disposed(by: self.disposeBag)
        }
        
        self.segmentController.do {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(self.view.snp.topMargin).offset(16)
                make.left.right.equalToSuperview().inset(8)
            }
            $0.insertSegment(withTitle: "All", at: PostSegmentValue.all.rawValue, animated: false)
            $0.insertSegment(withTitle: "Favorite", at: PostSegmentValue.favorite.rawValue, animated: false)
            $0.selectedSegmentIndex = 0
            $0.tintColor = .turquoiseBlue
            $0.rx.controlEvent(UIControlEvents.valueChanged)
                .map { _ in PostSegmentValue.init(rawValue: self.segmentController.selectedSegmentIndex)! }
                .flatMap { self.viewModel.rx.getBySegment(segment: $0) }
                .bind(to: self.data)
                .disposed(by: self.disposeBag)
        }
        
        self.deleteAllButton.do {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.bottom.equalTo(self.view.snp.bottomMargin)
                make.left.right.equalToSuperview()
                make.height.equalTo(44)
            }
            $0.setTitle("Delete All", for: .normal)
            $0.setTitleColor(.red, for: .normal)
            $0.rx.tap
                .map { _ -> [Post] in
                    return []
                }
                .bind(to: self.data)
                .disposed(by: self.disposeBag)
        }
        
        self.tableView = UITableView(frame: .zero, style: .plain).then {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(self.segmentController.snp.bottom).offset(8)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.deleteAllButton.snp.top)
            }
            $0.rowHeight = 120
            $0.backgroundColor = .lightGrayBG
            $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
            $0.showsVerticalScrollIndicator = false
            $0.separatorColor = .lightGrayBG
        }
        
        self.noResults.do {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(16)
                make.centerY.equalTo(self.tableView)
            }
            $0.font = UIFont.OMPHeader
            $0.numberOfLines = 3
            $0.text = "Bummer!\nNo post here\n😭"
            $0.textColor = .dusk
            $0.textAlignment = .center
            $0.isHidden = true
            self.data.map { $0.count > 0 }
                .bind(to: $0.rx.isHidden)
                .disposed(by: self.disposeBag)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadPosts()
        self.tableView.reloadData()
    }
    
    private func configureTableView() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionOfPosts>(configureCell: { (_, tv: UITableView, ip: IndexPath, item: Post) -> UITableViewCell in
            guard let cell = tv.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: ip) as? PostTableViewCell else {
                return UITableViewCell(frame: .zero)
            }
            return cell.then {
                $0.set(data: item, context: self.viewModel.context)
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
                let result = self?.data.value.filter { event.element != $0 } ?? []
                self?.data.accept(result)
            }
            .disposed(by: disposeBag)

        self.tableView.rx.modelSelected(Post.self)
            .asDriver()
            .drive(onNext: { [weak self] post in
                guard let `self` = self else {
                    return
                }
                self.viewModel.markAsRead(post: post)
                let model = PostDetailModel(
                    api: OMPRepository(mocked: false),
                    post: post)
                let viewModel = PostDetailViewModel(model: model, context: self.viewModel.context)
                let viewController = PostDetailViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func reloadPosts() {
        guard let segment = PostSegmentValue(rawValue: self.segmentController.selectedSegmentIndex) else {
            return
        }
        self.viewModel.rx.getBySegment(segment: segment)
            .subscribe(onNext: { [weak self] posts in
                self?.data.accept(posts)
            })
            .disposed(by: self.disposeBag)
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
