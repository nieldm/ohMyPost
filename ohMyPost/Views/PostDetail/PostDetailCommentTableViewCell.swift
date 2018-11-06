import UIKit
import ohMyPostBase

class PostDetailCommentTableViewCell: UITableViewCell {

    static let identifier = "PostDetailCommentTableViewCell"
    
    lazy var headerLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.headerLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(16)
                make.right.bottom.equalToSuperview().inset(16)
            }
            $0.numberOfLines = 0
            $0.text = "Comments"
            $0.font = .OMPHeader
            $0.textColor = .dusk
        }
    }
    
    func set(data: [Comment]) {
        self.headerLabel.text = "Comments (\(data.count))"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}

}
