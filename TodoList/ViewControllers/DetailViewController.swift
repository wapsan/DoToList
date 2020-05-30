import UIKit


class DetailViewController: UIViewController {
    
    //MARK: - GUI roperties
    lazy var noteTittleLabel: UILabel = {
        let label = UILabel()
        label.text = self.note?.tittle
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = self.note?.description
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteTittleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var noteDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - Private properties
    private var note: Note?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setGuiElements()
        self.view.backgroundColor = .yellow
       
    }
    
    //MARK: - Private methods
    private func setGuiElements() {
        self.view.addSubview(self.noteTittleLabel)
        self.view.addSubview(self.noteDescriptionLabel)
        self.view.addSubview(self.noteTittleTextField)
        self.view.addSubview(self.noteDescriptionTextField)
        self.setConstrasints()
    }
    
    //MARK: - Constraints
    private func setConstrasints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.noteTittleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            self.noteTittleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            self.noteTittleLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            self.noteTittleTextField.centerYAnchor.constraint(equalTo: self.noteTittleLabel.centerYAnchor),
            self.noteTittleTextField.heightAnchor.constraint(equalTo: self.noteTittleLabel.heightAnchor),
            self.noteTittleTextField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
            self.noteTittleTextField.leftAnchor.constraint(equalTo: self.noteTittleLabel.rightAnchor, constant: 16),
            self.noteTittleTextField.widthAnchor.constraint(equalTo: self.noteTittleLabel.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            self.noteDescriptionLabel.topAnchor.constraint(equalTo: self.noteTittleLabel.bottomAnchor, constant: 16),
            self.noteDescriptionLabel.heightAnchor.constraint(equalTo: self.noteTittleLabel.heightAnchor, multiplier: 1),
            self.noteDescriptionLabel.centerXAnchor.constraint(equalTo: self.noteTittleLabel.centerXAnchor),
            self.noteDescriptionLabel.widthAnchor.constraint(equalTo: self.noteTittleLabel.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            self.noteDescriptionTextField.topAnchor.constraint(equalTo: self.noteTittleTextField.bottomAnchor, constant: 16),
            self.noteDescriptionTextField.heightAnchor.constraint(equalTo: self.noteTittleTextField.heightAnchor, multiplier: 1),
            self.noteDescriptionTextField.centerXAnchor.constraint(equalTo: self.noteTittleTextField.centerXAnchor),
            self.noteDescriptionTextField.widthAnchor.constraint(equalTo: self.noteTittleTextField.widthAnchor, multiplier: 1)
        ])
    }
    
    //MARK: - Publick methods
    func setNote(to note: Note) {
        self.note = note
    }
    
}

//MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let textFromTextField = textField.text else { return false}
        if textField.tag == 1 {
            self.noteTittleLabel.text = textFromTextField
            self.note?.tittle = textFromTextField
            textField.text = nil
        } else {
            self.noteDescriptionLabel.text = textFromTextField
            self.note?.description = textFromTextField
            textField.text = nil
        }
        return true
    }
    
}
