
import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    //MARK: - GUI Properties
    lazy var customTittleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tittle label"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var customDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail label text"
        label.font = .systemFont(ofSize: 17)
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
    
    
    //MARK: - Properties
    static let reuseID = "MyTableViewCell"
    var nextButtonAction: (()-> Void)?
    
    //MARK: - Initilization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: MyTableViewCell.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Publick methods
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.customTittleLabel)
        self.addSubview(self.customDetailLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.nextButton)
        self.selectionStyle = .none
        self.setUpContentView()
        self.setUpConstraints()
    }
    
    //MARK: - Private methods
    private func setUpContentView() {
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        self.contentView.backgroundColor = .darkGray
        self.contentView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
        ])
    }
    
    //MARK: - Constraints
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.customTittleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                                         constant: 16),
            self.customTittleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                        constant: 8),
            self.customTittleLabel.heightAnchor.constraint(equalTo: self.customDetailLabel.heightAnchor,
                                                           multiplier: 1),
            self.customTittleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,
                                                          multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            self.customDetailLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                                         constant:  16),
            self.customDetailLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                           constant: -8),
            self.customDetailLabel.widthAnchor.constraint(equalTo: self.customTittleLabel.widthAnchor,
                                                          multiplier: 1),
            self.customDetailLabel.topAnchor.constraint(equalTo: self.customTittleLabel.bottomAnchor,
                                                        constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            self.dateLabel.leftAnchor.constraint(equalTo: self.customDetailLabel.rightAnchor,
                                                 constant: 8),
            self.dateLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                  constant: -16),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.customDetailLabel.centerYAnchor),
            self.dateLabel.heightAnchor.constraint(equalTo: self.customDetailLabel.heightAnchor,
                                                   multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            self.nextButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.nextButton.centerYAnchor.constraint(equalTo: self.customTittleLabel.centerYAnchor),
            self.nextButton.heightAnchor.constraint(equalTo: self.dateLabel.heightAnchor, multiplier: 1),
            self.nextButton.widthAnchor.constraint(equalTo: self.nextButton.heightAnchor, multiplier: 1)
        ])
    }
    
    //MARK: - Actions
    @objc func nextButtonTouched() {
        self.nextButtonAction?()
    }
    
}
