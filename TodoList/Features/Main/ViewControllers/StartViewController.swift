import UIKit
import SnapKit

class StartViewController: MainStyleViewController {
    
    //MARK: - Private properties
    private lazy var edgeInsets = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
    
    //MARK: - GUI Properties
    private lazy var myNotesButton: UIButton = {
        let button = UIButton()
        button.setTitle("My notes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(self.myNotesButtonPressed), for: .touchUpInside)
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
        self.view.addSubview(self.myNotesButton)
        self.view.addSubview(self.greetingView)
        self.setUpNavigationBar()
        self.setUpConstrains()
        self.setUpGreetingviewLayout()
    }
    
    private func setUpNavigationBar() {
        self.title = "Welcome"
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setUpGreetingviewLayout() {
        self.greetingView.iconImageView.setNeedsLayout()
        self.greetingView.iconImageView.layoutIfNeeded()
        self.greetingView.iconImageView.layer.cornerRadius = self.greetingView.iconImageView.frame.height / 2
    }
    
    private func pushTodoListViewController() {
        let toDoListVC = ToDoListViewController()
        self.navigationController?.pushViewController(toDoListVC, animated: true)
    }
    
    //MARK: - Constraints
    private func setUpConstrains() {
        self.greetingView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeArea.snp.top).inset(self.edgeInsets)
            make.left.equalTo(self.safeArea.snp.left).inset(self.edgeInsets)
            make.right.equalTo(self.safeArea.snp.right).inset(self.edgeInsets)
            make.height.equalTo(self.safeArea.snp.height).multipliedBy(0.5)
        }
        
        self.myNotesButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.bottom.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(self.greetingView.snp.height).multipliedBy(0.2)
        }
    }
    
    //MARK: - Actions
    @objc func myNotesButtonPressed() {
        self.pushTodoListViewController()
    }
}

