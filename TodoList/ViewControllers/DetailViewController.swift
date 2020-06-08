import UIKit


class DetailViewController: UIViewController {
    
    //MARK: - GUI roperties
    lazy var noteTittleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tittle"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteTittleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = 1
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.font = .systemFont(ofSize: 17)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var noteDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = 2
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.font = .systemFont(ofSize: 17)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var createNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create note", for: .normal)
        button.tintColor = .black
        button.backgroundColor  = .orange
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.createNotePressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Private properties
    private var note: Note?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGuiElements()
        self.view.backgroundColor = .yellow
    }
    
    //MARK: - Private methods
    private func setGuiElements() {
        self.view.addSubview(self.noteTittleLabel)
        self.view.addSubview(self.noteDescriptionLabel)
        self.view.addSubview(self.noteTittleTextField)
        self.view.addSubview(self.noteDescriptionTextField)
        self.view.addSubview(self.createNoteButton)
        self.setConstrasints()
    }
    
    private func resetTextFields() {
        self.noteTittleTextField.text = nil
        self.noteDescriptionTextField.text = nil
    }
    
    //MARK: - Constraints
    private func setConstrasints() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.noteTittleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.snp.top).inset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.noteTittleTextField.snp.top).offset(-8)
        }
        
        self.noteTittleTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(self.noteDescriptionLabel.snp.top).offset(-8)
        }
        
        self.noteDescriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.noteDescriptionTextField.snp.top).offset(-8)
        }
        
        self.noteDescriptionTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(self.createNoteButton.snp.top).offset(-16)
        }
        
        self.createNoteButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Publick methods
    func setNote(to note: Note) {
        self.note = note
    }
    
    //MARK: - Action
    @objc private func createNotePressed() {
        guard let noteTittle = self.noteTittleTextField.text else { return }
        guard let noteDescription = self.noteDescriptionTextField.text else { return }
        let date = DateManager.shared.currnetDate
        let note = NoteCodable(tittle: noteTittle, description: noteDescription, date: date)
        //  let note = Note(tittle: noteTittle, description: noteDescription, date: date)
        //  NotesFileManager.shared.save(note: note)
        // CodableFileManager.shared.addNote(note: note)
        UserDefaultsManager.shared.add(note: note)
        self.resetTextFields()
    }
    
}

//MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let textFromTextField = textField.text else { return false}
        if textField.tag == 1 {
            self.noteTittleLabel.text = textFromTextField
            self.note?.noteTittle = textFromTextField
            textField.text = nil
        } else {
            self.noteDescriptionLabel.text = textFromTextField
            self.note?.noteDescription = textFromTextField
            textField.text = nil
        }
        return true
    }
    
}
