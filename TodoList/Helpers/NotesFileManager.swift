import Foundation

class NotesFileManager {
    
    //MARK: - Static properties
    static let shared = NotesFileManager()
    
    //MARK: - Private properties
    private var directoryURL: URL
    private var filePath: URL?
    private var noteList: [Note] = []
    
    //MARK: - Initialization
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       // self.fethcNoteList()
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
    func addNote(_ note: Note) {
        self.noteList.append(note)
        self.updateNotelist(for: self.noteList)
    }
    
    func getNoteList() -> [Note] {
        self.fethcNoteList()
        return self.noteList
    }
    
    func removeNote(at index: Int) {
        self.noteList.remove(at: index)
        self.updateNotelist(for: self.noteList)
    }
    
    func updateNotelist(for noteList: [Note]) {
        if let filePath = directoryURL.appendingPathComponent("user") as URL?,
            let encodeData = try? JSONEncoder().encode(noteList) {
            do {
                try encodeData.write(to: filePath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
