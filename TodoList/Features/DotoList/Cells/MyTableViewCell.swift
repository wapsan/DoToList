import UIKit
import SnapKit

class MyTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "MyTableViewCell"
    
    //MARK: - Private properties
    private lazy var conteinerViewInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private lazy var edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    //MARK: - GUI Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tittle label"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail label text"
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
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
    func setUpCell(for note: Note) {
        self.titleLabel.text = note.noteTitle
        self.descriptionLabel.text = note.noteDescription
        self.dateLabel.text = note.date
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
    }
    
    private func setUpCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    //MARK: - Constraints
    private func setUpConstraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview().inset(self.conteinerViewInsets)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(self.edgeInsets)
        }
        
        self.arrowIcon.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualToSuperview().inset(self.edgeInsets)
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(self.edgeInsets.left)
            make.right.equalToSuperview().inset(self.edgeInsets)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.size.equalTo(self.arrowIcon)
        }
        
        descriptionLabel.snp.contentCompressionResistanceHorizontalPriority = 250
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(self.edgeInsets.top)
            make.left.bottom.equalToSuperview().inset(self.edgeInsets)
        }
        
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.descriptionLabel.snp.top)
            make.left.greaterThanOrEqualTo(self.descriptionLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(self.edgeInsets)
            make.bottom.equalToSuperview().inset(self.edgeInsets)
        }
    }
}
