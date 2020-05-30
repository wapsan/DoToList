import UIKit




class RootviewController: UIViewController {

    //MARK: - GUI Properties
     lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.nextButtonTouched), for: .touchUpInside)
        return button
    }()
    
    lazy var customView: GreetingView = {
        let view = GreetingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    //MARK: - Private properties
    private var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .lightGray
        self.title = "Root view controller"
        self.view.addSubview(self.continueButton)
        self.view.addSubview(self.customView)
        print("viewDidLoad")
        self.setUpConstrains()
        
self.customView.iconImageView.setNeedsLayout()
        self.customView.iconImageView.layoutIfNeeded()
        self.customView.iconImageView.layer.cornerRadius = self.customView.iconImageView.frame.height / 2
        print(self.customView.iconImageView.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewDidDisappear")
    }
    
    //MARK: - mETHODS
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            self.continueButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
             self.continueButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
             self.continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
             self.continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            self.customView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 32),
            self.customView.leftAnchor.constraint(equalTo: self.safeArea.leftAnchor, constant: 32),
            self.customView.rightAnchor.constraint(equalTo: self.safeArea.rightAnchor, constant: -32),
            self.customView.heightAnchor.constraint(equalTo: self.safeArea.heightAnchor, multiplier: 1/2)
            
          //  self.customView.bottomAnchor.constraint(equalTo: self.continueButton.topAnchor, constant: -50)
        ])
    }
    
    //MARK: - Actions
    @objc func nextButtonTouched() {
        let toDoListVC = ToDoListViewController()
        self.navigationController?.pushViewController( toDoListVC, animated: true)
    }
    
    



}

