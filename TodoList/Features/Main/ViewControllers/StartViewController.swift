import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    //MARK: - Private properties
    private var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    private var edgeInsets = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
    
    //MARK: - GUI Properties
    lazy var backgroumdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(self.nextButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var greetingView: GreetingView = {
        let view = GreetingView()
       
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpGuiElements()
    }
    
    //MARK: - Private methods
    private func setUpGuiElements() {
        self.backgroumdImageView.image = UIImage(named: "backgroundImage")
        self.view.addSubview(self.backgroumdImageView)
        self.view.addSubview(self.continueButton)
        self.view.addSubview(self.greetingView)
        self.setUpNavigationBar()
        self.setUpConstrains()
        self.setUpGreetingview()
    }
    private func setUpNavigationBar() {
        self.title = "Welcome"
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setUpGreetingview() {
        self.greetingView.iconImageView.setNeedsLayout()
        self.greetingView.iconImageView.layoutIfNeeded()
        self.greetingView.iconImageView.layer.cornerRadius = self.greetingView.iconImageView.frame.height / 2
    }
    
    private func pushTodoList() {
       let toDoListVC = ToDoListViewController()
        self.navigationController?.pushViewController( toDoListVC, animated: true)
    }
    
    //MARK: - Constraints
    private func setUpConstrains() {
        self.backgroumdImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeArea.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.greetingView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeArea.snp.top).inset(self.edgeInsets)
            make.left.equalTo(self.safeArea.snp.left).inset(self.edgeInsets)
            make.right.equalTo(self.safeArea.snp.right).inset(self.edgeInsets)
            make.height.equalTo(self.safeArea.snp.height).multipliedBy(0.5)
        }
        
        self.continueButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.bottom.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(self.greetingView.snp.height).multipliedBy(0.2)
        }
    }
    
    //MARK: - Actions
    @objc func nextButtonTouched() {
        self.pushTodoList()
    }
}

