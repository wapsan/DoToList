import Foundation

class NotesFileManager {
    
    //MARK: - Static propertie
    static let shared = NotesFileManager()
    
    //MARK: - Private properties
    private var directoryURL: URL
    private var filePath: URL?
    private var _noteList: [Note] = []
    
    //MARK: - Properties
    var noteList: [Note]  {
        get {
            self.fethcNoteList()
            return self._noteList
        }
    }
    
    //MARK: - Initialization
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory,
                                                     in: .userDomainMask)[0]
    }
    
    //MARK: - Private methods
    private func fethcNoteList() {
        let localPath = self.directoryURL.appendingPathComponent("user") as URL?
        guard let filePath = localPath?.path,
            let data = FileManager.default.contents(atPath: filePath),
            let noteList = try? JSONDecoder().decode([Note].self, from: data) else { return }
        self._noteList = noteList
    }
    
    private func postNoteListChangedNotification() {
        NotificationCenter.default.post(name: .noteListWasChanged, object: nil)
    }
    
    //MARK: - Publick methods
    func addNote(_ note: Note) {
        self._noteList.append(note)
        self.updateNotelist()
    }
    
    func removeNote(at index: Int) {
        self._noteList.remove(at: index)
        self.updateNotelist()
    }
    
    func updateNotelist(to notelist: [Note]) {
        if let filePath = directoryURL.appendingPathComponent("user") as URL?,
            let encodeData = try? JSONEncoder().encode(notelist) {
            do {
                try encodeData.write(to: filePath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateNotelist() {
        if let filePath = directoryURL.appendingPathComponent("user") as URL?,
            let encodeData = try? JSONEncoder().encode(self._noteList) {
            do {
                try encodeData.write(to: filePath)
            } catch {
                print(error.localizedDescription)
            }
        }
        self.postNoteListChangedNotification()
    }
}
