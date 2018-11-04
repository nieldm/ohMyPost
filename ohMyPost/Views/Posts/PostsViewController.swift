import UIKit
import Then
import SnapKit
import RxDataSources
import ohMyPostBase
import RxSwift

class PostsViewController: UIViewController {

    private let viewModel: PostViewModel
    private let disposeBag = DisposeBag()
    
    fileprivate var collectionView: UICollectionView! {
        didSet {
            self.configureCollectionView()
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
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            $0.backgroundColor = .lightGrayBG
            $0.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
            $0.showsVerticalScrollIndicator = false
        }
        self.collectionView = collectionView
    }
    
    private func configureCollectionView() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfPosts>(configureCell: { (_, cv: UICollectionView, ip: IndexPath, item: Post) -> UICollectionViewCell in
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: ip) as? PostCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell.then {
                $0.set(data: item)
            }
        })
        self.viewModel.rx.getPosts()
            .map { [SectionOfPosts(header: "Initial", items: $0)] }
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)

        let _ = self.collectionView.rx.setDelegate(self)
    }

}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: 120
        )
    }
    
}
