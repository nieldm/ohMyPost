import UIKit
import RxSwift

class PostDetailViewController: UIViewController {
 
    private let disposeBag = DisposeBag()
    let viewModel: PostDetailViewModel
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = PostDetailView().then {
            $0.render(withModel: self.viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil).then {
            $0.tintColor = .turquoiseBlue
            self.navigationItem.rightBarButtonItem = $0
            $0.rx.tap
                .subscribe(onNext: { [weak self] in
                    print("Favorite 💖")
                    self?.viewModel.markAsFavorite()
                })
                .disposed(by: self.disposeBag)
        }
    }

}
