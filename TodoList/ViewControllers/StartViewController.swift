import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    //MARK: - Private properties
    private var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    //MARK: - GUI Properties
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.nextButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var greetingView: GreetingView = {
        let view = GreetingView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpGuiElements()
    }
    
    //MARK: - Private methods
    private func setUpGuiElements() {
        self.view.backgroundColor  = .lightGray
        self.title = "Welcome"
        self.view.addSubview(self.continueButton)
        self.view.addSubview(self.greetingView)
        self.setUpConstrains()
        self.setUpGreetingview()
        
    }
    
    private func setUpGreetingview() {
        self.greetingView.iconImageView.setNeedsLayout()
        self.greetingView.iconImageView.layoutIfNeeded()
        self.greetingView.iconImageView.layer.cornerRadius = self.greetingView.iconImageView.frame.height / 2
    }
    
    //MARK: - Constraints
    private func setUpConstrains() {
        self.greetingView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeArea.snp.top).inset(32)
            make.left.equalTo(self.safeArea.snp.left).inset(32)
            make.right.equalTo(self.safeArea.snp.right).inset(32)
            make.height.equalTo(self.safeArea.snp.height).multipliedBy(0.5)
        }
        
        self.continueButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(self.greetingView.snp.height).multipliedBy(0.2)
        }
    }
    
    //MARK: - Actions
    @objc func nextButtonTouched() {
        let toDoListVC = ToDoListViewController()
        self.navigationController?.pushViewController( toDoListVC, animated: true)
    }
}

