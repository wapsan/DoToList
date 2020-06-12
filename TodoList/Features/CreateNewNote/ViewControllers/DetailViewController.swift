import UIKit

class DetailViewController: MainStyleViewController {
    
    //MARK: - Private properties
    private var note: Note?
    private lazy var edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private lazy var itemsHeight: CGFloat = 50
    
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
        textField.font = .systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var noteDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.tag = 2
        textField.font = .systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.setDate(Date(), animated: true)
        datePicker.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        datePicker.layer.cornerRadius = 20
        return datePicker
    }()
    
    lazy var createNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create note", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor  = .systemPink
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.createNoteButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGuiElements()
        self.setMainButton()
    }
    
    //MARK: - Private methods
    private func setGuiElements() {
        self.view.backgroundColor = .yellow
        self.view.addSubview(self.noteTittleLabel)
        self.view.addSubview(self.noteDescriptionLabel)
        self.view.addSubview(self.noteTittleTextField)
        self.view.addSubview(self.noteDescriptionTextField)
        self.view.addSubview(self.datePicker)
        self.view.addSubview(self.createNoteButton)
        self.setConstrasints()
    }
    
    private func resetTextFields() {
        self.noteTittleTextField.text = nil
        self.noteDescriptionTextField.text = nil
    }
    
    
    //MARK: - Constraints
    private func setConstrasints() {
        self.noteTittleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.snp.top).inset(self.edgeInsets)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.bottom.equalTo(self.noteTittleTextField.snp.top).offset(-self.edgeInsets.bottom / 2)
        }
        
        self.noteTittleTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(self.itemsHeight)
            make.bottom.equalTo(self.noteDescriptionLabel.snp.top).offset(-self.edgeInsets.bottom / 2)
        }
        
        self.noteDescriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.bottom.equalTo(self.noteDescriptionTextField.snp.top).offset(-self.edgeInsets.bottom / 2)
        }
        
        self.noteDescriptionTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(self.itemsHeight)
            make.bottom.equalTo(self.datePicker.snp.top).offset(-self.edgeInsets.bottom)
        }
        
        self.datePicker.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(self.itemsHeight * 3)
            make.bottom.equalTo(self.createNoteButton.snp.top).offset(-self.edgeInsets.bottom)
        }
        
        self.createNoteButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.height.equalTo(self.itemsHeight)
        }
    }
    
    //MARK: - Publick methods
    func setNote(to note: Note) {
        self.note = note
    }
    
    //MARK: - Private methods
    func setMainButton() {
        if let note = self.note {
           self.noteDescriptionTextField.text = note.noteDescription
            self.noteTittleTextField.text = note.noteTitle
            self.createNoteButton.setTitle("Change", for: .normal)
        } else {
            self.createNoteButton.setTitle("Add note", for: .normal)
        }
    }
    
    //MARK: - Action
    @objc private func createNoteButtonPressed() {
        guard let noteTittle = self.noteTittleTextField.text,
            noteTittle != "" else { return }
        guard let noteDescription = self.noteDescriptionTextField.text else { return }
        let date = DateManager.shared.getFormateDate(from: self.datePicker.date)
        let note = Note(title: noteTittle, description: noteDescription, date: date)
        if let note = self.note {
            note.noteTitle = noteTittle
            note.noteDescription = noteDescription
            note.date = date
            NotesFileManager.shared.updateNotelist()
        } else {
            NotesFileManager.shared.addNote(note)
        }
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
            self.note?.noteTitle = textFromTextField
            textField.text = nil
        } else {
            self.noteDescriptionLabel.text = textFromTextField
            self.note?.noteDescription = textFromTextField
            textField.text = nil
        }
        return true
    }
    
}
