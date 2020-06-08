
import Foundation

class UserDefaultsManager {
    
    //MARK: - Static properties
    static let shared = UserDefaultsManager()
    
    //MARK: - Private properties
    private var noteList: [NoteCodable] = []
    
    //MARK: - Initialization
    init() {
        self.fetchNoteList()
    }
    
    //MARK: - Public methods
    func getNoteList() -> [NoteCodable] {
        return self.noteList
    }
    
    func add(note: NoteCodable) {
        self.noteList.append(note)
        self.updateData(for: self.noteList)
    }
    
    func removeNote(at index: Int) {
        self.noteList.remove(at: index)
        self.updateData(for: self.noteList)
    }
    
    //MARK: - Private methods
    private func fetchNoteList() {
        if let data = UserDefaults.standard.data(forKey: "userDefaultsData") {
            let noteList = try? JSONDecoder().decode([NoteCodable].self, from: data)
            self.noteList += noteList ?? []
        }
    }
    
    private func updateData(for noteList: [NoteCodable]) {
        if let encodedData = try? JSONEncoder().encode(noteList) {
            UserDefaults.standard.set(encodedData, forKey: "userDefaultsData")
        }
        
    }
    
    
    
    
}
