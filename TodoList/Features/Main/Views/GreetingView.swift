import UIKit
import SnapKit

class GreetingView: UIView {
    
    //MARK: - Private properties
    private lazy var edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    //MARK: - GUI Properties
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, User"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    //MARK: - Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func initView() {
        self.backgroundColor = .systemPink
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.iconImageView.image = UIImage(named: "avatarIcon")
        self.addSubview(self.greetingLabel)
        self.addSubview(self.iconImageView)
        self.setUpConstraints()
    }
    
    //MARK: - Constraints
    private func setUpConstraints() {
        self.greetingLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().inset(self.edgeInsets)
        }
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.bottom.equalTo(self.greetingLabel.snp.top).offset(-self.edgeInsets.bottom)
            make.height.equalTo(self.iconImageView.snp.width)
        }
    }
}
