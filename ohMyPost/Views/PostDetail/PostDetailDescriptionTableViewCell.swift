import UIKit
import ohMyPostBase

class PostDetailDescriptionTableViewCell: UITableViewCell {
    static let identifier = "PostDetailDescriptionTableViewCell"
    
    lazy var titleLabel = UILabel(frame: .zero)
    lazy var bodyLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(16)
            }
            $0.numberOfLines = 0
            $0.text = "Title"
            $0.font = .OMPHeader
            $0.textColor = .dusk
        }
        
        self.bodyLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.bottom.equalToSuperview().inset(16)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            }
            $0.numberOfLines = 0
            $0.text = "SubTitle"
            $0.font = UIFont.OMPSubTitle
            $0.textColor = UIColor.wisteria
        }
    }
    
    func set(data: Post) {
        self.titleLabel.text = data.title.capitalized
        self.bodyLabel.text = data.body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
}
