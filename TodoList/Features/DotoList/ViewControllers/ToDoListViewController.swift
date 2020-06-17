import UIKit
import SnapKit

class ToDoListViewController: MainStyleViewController {

    //MARK: - Private properties
    private lazy var noteList: [Note] = NotesFileManager.shared.noteList
    private lazy var isNoteListChanged: Bool = false
    
    //MARK: - GUI Properties
    private lazy var noNoteLabel: UILabel  = {
        let label = UILabel()
        label.text = "No notes yet."
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseID)
        tableView.separatorStyle = .none
        return tableView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewController()
        self.setUpNavigationBar()
        self.addObserverForChangingNoteList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isNoteListChanged {
            self.noteList = NotesFileManager.shared.noteList
            self.setUpViewController()
            self.isNoteListChanged = false
        }
    }
    
    //MARK: - Private methods
    private func setUpViewController() {
        self.title = "My notes"
        if self.noteList.isEmpty {
            self.removeTableNoteList()
            self.addNoNoteLabel()
        } else {
            self.removeNoNoteLablel()
            self.addTableNoteList()
            self.tableView.reloadData()
        }
    }
    
    private func addTableNoteList() {
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = .clear
        self.activateTableConstraints()
    }
    
    private func removeTableNoteList() {
        self.tableView.snp.removeConstraints()
        self.tableView.removeFromSuperview()
    }
    
    private func addNoNoteLabel() {
        self.view.addSubview(self.noNoteLabel)
        self.activateNoNoteLabelConstraint()
    }
    
    private func removeNoNoteLablel() {
        self.noNoteLabel.snp.removeConstraints()
        self.noNoteLabel.removeFromSuperview()
    }
        
    private func pushNewNoteVC() {
        let newNoteVC = DetailViewController()
        newNoteVC.title = "New note"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
    
    private func pushEditNoteVC(with note: Note) {
        let editNoteVC = DetailViewController()
        editNoteVC.setNote(to: note)
        editNoteVC.navigationItem.title = note.date
        self.navigationController?.pushViewController(editNoteVC, animated: true)
    }
    
    private func setUpNavigationBar() {
        let addNoteButton = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(self.addNoteButtonPressed))
        self.navigationItem.rightBarButtonItems = [addNoteButton, self.editButtonItem]
        self.editButtonItem.action = #selector(self.editNoteListButtonPressed)
    }
    
    private func addObserverForChangingNoteList() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.noteListWasChanged),
                                               name: .noteListWasChanged,
                                               object: nil)
    }
    
    //MARK: - Constraints
    private func activateTableConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
   
    private func activateNoNoteLabelConstraint() {
        self.noNoteLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    @objc private func noteListWasChanged() {
        self.setUpViewController()
        self.isNoteListChanged = true
    }
    
    @objc private func addNoteButtonPressed() {
        self.pushNewNoteVC()
    }
    
    @objc private func editNoteListButtonPressed() {
        self.tableView.setEditing(self.tableView.isEditing ? false : true, animated: true)
        if !self.tableView.isEditing {
            self.editButtonItem.title = "Edit"
            NotesFileManager.shared.updateNotelist(to: self.noteList)
        } else {
            self.editButtonItem.title = "Done"
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseID,
                                                    for: indexPath) as? MyTableViewCell {
            let note = self.noteList[indexPath.row]
            cell.setUpCell(for: note)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.noteList[indexPath.row]
        self.pushEditNoteVC(with: note)
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedNoteIndex = indexPath.row
            self.noteList.remove(at: deletedNoteIndex)
            self.tableView.performBatchUpdates({ [weak self] in
                guard let self = self else { return }
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }) { (_) in
                NotesFileManager.shared.removeNote(at: deletedNoteIndex)
            }
        } else if editingStyle == .insert {
            NotesFileManager.shared.updateNotelist()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        self.noteList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
 
