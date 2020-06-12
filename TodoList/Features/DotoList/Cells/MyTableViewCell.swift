import UIKit
import SnapKit

class MyTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "MyTableViewCell"
    var nextButtonAction: (()-> Void)?
    
    //MARK: - GUI Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tittle label"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail label text"
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrowtriangle.right")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 5)
        view.layer.shadowOpacity = 5
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initilization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: MyTableViewCell.reuseID)
        self.setUpContainerView()
        self.initCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Publick methods
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Private methods
    private func setUpContainerView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.dateLabel)
        self.containerView.addSubview(self.arrowIcon)
    }
    
    private func initCell() {
        self.setUpCell()
        self.setUpContainerView()
        self.setUpConstraints()
        self.containerView.isUserInteractionEnabled = false
    }
    
    private func setUpCell() {
        self.selectionStyle = .none
    }
    
    //MARK: - Constraints
    private func setUpConstraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview().inset(8)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(16)
        }
        
        self.arrowIcon.snp.makeConstraints { (make) in
           make.top.greaterThanOrEqualToSuperview().inset(5)
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.size.equalTo(self.arrowIcon)
        }
        
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.left.bottom.equalToSuperview().inset(16)
        }
        
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.descriptionLabel.snp.top)
            make.left.greaterThanOrEqualTo(self.descriptionLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
