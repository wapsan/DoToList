import Foundation

class NotesFileManager {
    
    //MARK: - Static propertie
    static let shared = NotesFileManager()
    
    //MARK: - Private properties
    private var directoryURL: URL
    private var filePath: URL?
    private var notelist: [Note] = []
    
    //MARK: - Initialization
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.filePath = directoryURL.appendingPathComponent("user") as URL?
        self.fetchNoteList()
    }
    
    //MARK: - Publick methods
    func removeNote(at index: Int) {
        self.notelist.remove(at: index)
        self.updateData(for: self.notelist)
    }
    
    func save(note: Note) {
        self.notelist.append(note)
        self.updateData(for: self.notelist)
    }
    
    func getNoteList() -> [Note] {
        return self.notelist
    }
    
    //MARK: - Private methods
    private func fetchNoteList() {
        if let filePath = self.filePath {
            do {
                let data = try Data(contentsOf: filePath)
                let noteList  = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Note]
                self.notelist += noteList ?? []
            } catch {
                print("Unarchiving error")
            }
        }
    }
    
    private func updateData<T>(for noteList: [T]) {
        if let filePath = self.filePath {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: noteList,
                                                            requiringSecureCoding: false)
                try data.write(to: filePath)
            } catch {
                print("Archiving error")
            }
        }
    }
    
}
