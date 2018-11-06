import UIKit
import ohMyPostBase

class PostDetailUserTableViewCell: UITableViewCell {

    static let identifier = "PostDetailUserTableViewCell"
    
    lazy var headerLabel = UILabel(frame: .zero)
    lazy var nameLabel = UILabel(frame: .zero)
    lazy var emailLabel = UILabel(frame: .zero)
    lazy var phoneLabel = UILabel(frame: .zero)
    lazy var websiteLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.headerLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(16)
            }
            $0.numberOfLines = 0
            $0.text = "User"
            $0.font = .OMPHeader
            $0.textColor = .dusk
        }
        
        self.nameLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(16)
                make.top.equalTo(self.headerLabel.snp.bottom).offset(8)
            }
            $0.numberOfLines = 0
            $0.font = UIFont.OMPSubTitle
            $0.textColor = UIColor.wisteria
        }
        
        self.emailLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(16)
                make.top.equalTo(self.nameLabel.snp.bottom).offset(8)
            }
            $0.numberOfLines = 0
            $0.font = UIFont.OMPSubTitle
            $0.textColor = UIColor.wisteria
        }
        
        self.phoneLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(16)
                make.top.equalTo(self.emailLabel.snp.bottom).offset(8)
            }
            $0.numberOfLines = 0
            $0.font = UIFont.OMPSubTitle
            $0.textColor = UIColor.wisteria
        }
        
        self.websiteLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.bottom.equalToSuperview().inset(16)
                make.top.equalTo(self.phoneLabel.snp.bottom).offset(8)
            }
            $0.numberOfLines = 0
            $0.font = UIFont.OMPSubTitle
            $0.textColor = UIColor.wisteria
        }
    }
    
    func set(data: User) {
        self.nameLabel.text = data.name
        self.emailLabel.text = data.email
        self.phoneLabel.text = data.phone
        self.websiteLabel.text = data.website
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}

}
