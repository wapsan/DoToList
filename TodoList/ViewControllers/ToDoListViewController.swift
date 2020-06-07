import UIKit

class ToDoListViewController: UIViewController {

    //MARK: - Private properties
    private var noteArray: [Note] = []
    
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
    
    private func setUpConstrains() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
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
        self.noteArray = NotesFileManager.shared.getNoteList()
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
    }
   
    //MARK: - Actions
    @objc private func addNote() {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseID,
                                                      for: indexPath) as! MyTableViewCell
        let note = self.noteArray[indexPath.row]
        cell.customTittleLabel.text = note.noteTittle
        cell.customDetailLabel.text = note.noteDescription
        cell.dateLabel.text = note.date
        cell.nextButtonAction = { self.pushDetailVC(with: note) }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedNoteIndex = indexPath.row
            NotesFileManager.shared.removeNote(at: deletedNoteIndex)
            self.noteArray.remove(at: deletedNoteIndex)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
}
 
