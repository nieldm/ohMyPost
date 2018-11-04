import UIKit
import ohMyPostBase

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostCollectionViewCell"
    
    private var titleLabel: UILabel!
    private var subTitleLabel: UILabel!
    private var iconImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .lightGrayBG
        
        self.contentView.do {
            $0.backgroundColor = .white
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
            $0.layer.addBorderAndShadow()
        }
        
        self.iconImageView = UIImageView(frame: CGRect.zero).then {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.size.equalTo(32)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(8)
            }
            $0.backgroundColor = .blue
        }
        
        self.titleLabel = UILabel(frame: CGRect.zero).then {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalTo(self.contentView.snp.centerY)
                make.left.equalTo(self.iconImageView.snp.right).offset(8)
                make.right.equalToSuperview().inset(8)
            }
            $0.numberOfLines = 2
            $0.text = "Title"
            $0.font = UIFont.OMPTitle
            $0.textColor = UIColor.dusk
        }
        
        self.subTitleLabel = UILabel(frame: CGRect.zero).then {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(self.contentView.snp.centerY)
                make.left.equalTo(self.iconImageView.snp.right).offset(8)
                make.right.equalToSuperview().inset(8)
            }
            $0.numberOfLines = 2
            $0.text = "SubTitle"
            $0.font = UIFont.OMPSubTitle
            $0.textColor = UIColor.wisteria
        }
    }
    
    func set(data: Post) {
        self.titleLabel.text = data.title.capitalized
        self.subTitleLabel.text = data.body
        self.iconImageView.isHidden = !data.unread()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
