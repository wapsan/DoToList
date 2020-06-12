import Foundation

class NotesFileManager {
    
    //MARK: - Static propertie
    static let shared = NotesFileManager()
    
    //MARK: - Private properties
    private var directoryURL: URL
    private var filePath: URL?
    var noteList: [Note]  = []
    
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
        self.noteList = noteList
    }
    
    //MARK: - Publick methods
    func loadNoteList() -> [Note] {
        self.fethcNoteList()
        return self.noteList
    }
    
    func addNote(_ note: Note) {
        self.noteList.append(note)
        self.updateNotelist()
    }
    
    func removeNote(at index: Int) {
        self.noteList.remove(at: index)
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
            let encodeData = try? JSONEncoder().encode(self.noteList) {
            do {
                try encodeData.write(to: filePath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
