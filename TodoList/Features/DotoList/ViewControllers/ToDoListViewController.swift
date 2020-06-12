import UIKit

class ToDoListViewController: UIViewController {

    //MARK: - Private properties
    private var noteList: [Note] = NotesFileManager.shared.loadNoteList()

    //MARK: - GUI Properties
    lazy var backgroumdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMainView()
        self.setUpConstrains()
        self.setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.noteList = NotesFileManager.shared.loadNoteList()
        self.tableView.reloadData()
    }
    
    //MARK: - Private methods
    private func setUpMainView() {
        self.title = "To do list"
        self.tableView.backgroundColor = .clear
        self.backgroumdImageView.image = UIImage(named: "backgroundImage")
        self.view.addSubview(self.backgroumdImageView)
        self.view.addSubview(self.tableView)
    }
    
    private func pushNewNoteVC() {
        let newNotVC = DetailViewController()
        newNotVC.title = "New note"
        self.navigationController?.pushViewController(newNotVC, animated: true)
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
        self.navigationItem.rightBarButtonItem = addNoteButton
        self.navigationItem.rightBarButtonItems = [addNoteButton, self.editButtonItem]
        self.editButtonItem.action = #selector(self.editNoteListButtonPressed)
    }
    
    //MARK: - Constraints
    private func setUpConstrains() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.backgroumdImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
   
    //MARK: - Actions
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
            cell.titleLabel.text = note.noteTitle
            cell.descriptionLabel.text = note.noteDescription
            cell.dateLabel.text = note.date
            cell.backgroundColor = .clear
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
            self.tableView.performBatchUpdates({
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
 
