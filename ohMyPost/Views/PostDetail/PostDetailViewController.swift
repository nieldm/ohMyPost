import UIKit

class PostDetailViewController: UIViewController {
 
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

}
