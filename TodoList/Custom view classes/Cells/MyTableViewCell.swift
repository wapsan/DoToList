import UIKit
import SnapKit

class MyTableViewCell: UITableViewCell {
    
    //MARK: - GUI Properties
    lazy var customTittleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tittle label"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var customDetailLabel: UILabel = {
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
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(self.nextButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 5)
        view.layer.shadowOpacity = 5
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Properties
    static let reuseID = "MyTableViewCell"
    var nextButtonAction: (()-> Void)?
    
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
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.customTittleLabel)
        self.containerView.addSubview(self.customDetailLabel)
        self.containerView.addSubview(self.dateLabel)
        self.containerView.addSubview(self.nextButton)
        self.containerView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview().inset(8)
        }
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
        self.customTittleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.centerY.equalTo(self.nextButton.snp.centerY)
        }
        
        self.customDetailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.customTittleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.width.equalTo(self.customTittleLabel.snp.width)
        }
        
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.customDetailLabel.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(self.customDetailLabel.snp.centerY)
        }
        
        self.nextButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.centerY.equalTo(self.customTittleLabel)
            make.height.width.equalTo(50)
        }
    }
    
    //MARK: - Actions
    @objc func nextButtonTouched() {
        self.nextButtonAction?()
    }
    
}
