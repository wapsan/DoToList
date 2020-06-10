import UIKit

class ToDoListViewController: UIViewController {

    //MARK: - Private properties
    private var noteList: [Note] = []
    
    //MARK: - GUI Properties
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
        self.title = "To do list"
        self.view.backgroundColor = .red
        self.view.addSubview(self.tableView)
        self.setUpConstrains()
        self.setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.noteList = NotesFileManager.shared.getNoteList()
        self.tableView.reloadData()
    }
    
    //MARK: - Private methods
    private func pushDetailVC(with note: Note) {
        let detailVC = DetailViewController()
        detailVC.setNote(to: note)
        detailVC.navigationItem.title = note.date
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func setUpNavigationBar() {
        let addNoteButton = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(self.addNote))
        self.navigationItem.rightBarButtonItem = addNoteButton
//        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
//                                            target: self,
//                                            action: #selector(self.editNote))
        self.navigationItem.rightBarButtonItems = [addNoteButton, self.editButtonItem]
       self.editButtonItem.action = #selector(self.editNote)
        
    }
    
    //MARK: - Constraints
    private func setUpConstrains() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
   
    //MARK: - Actions
    @objc private func addNote() {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc private func editNote() {
        self.tableView.setEditing(self.tableView.isEditing ? false : true, animated: true)
        self.tableView.isEditing ? print("Start editing") : print("End editing")
        self.noteList.forEach({print($0.noteTittle)})
        if !self.tableView.isEditing {
            self.noteList.forEach({print($0.noteTittle)})
            NotesFileManager.shared.updateNotelist(for: self.noteList)
        }
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseID,
                                                      for: indexPath) as! MyTableViewCell
        let note = self.noteList[indexPath.row]
        cell.tittleLabel.text = note.noteTittle
        cell.descriptionLabel.text = note.noteDescription
        cell.dateLabel.text = note.date
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
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
            print("here")
        }
    }
    
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        self.noteList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
    
}
 
