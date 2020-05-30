
import UIKit

class ToDoListViewController: UIViewController {

    //MARK: - Private properties
    private var model: [String] = Array(repeating: "Hello Sweetie", count: 10)
    private var noteArray: [Note] = Note.createNotesArryay()
    
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
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To do list"
        self.view.backgroundColor = .red
        self.view.addSubview(self.tableView)
        self.setUpConstrains()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK: - Private methods
    private func pushDetailVC(with note: Note) {
        let detailVC = DetailViewController()
        detailVC.setNote(to: note)
        detailVC.navigationItem.title = note.date
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
        cell.customTittleLabel.text = note.tittle
        cell.customDetailLabel.text = note.description
        cell.dateLabel.text = note.date
        cell.nextButtonAction = { self.pushDetailVC(with: note) }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height * 0.2
        return height
    }
    
  
 
    
}
 
