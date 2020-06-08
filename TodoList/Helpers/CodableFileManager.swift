import Foundation

class CodableFileManager {
    
    //MARK: - Static properties
    static let shared = CodableFileManager()
    
    //MARK: - Private properties
    private var directoryURL: URL
    private var filePath: URL?
    private var notelist: [NoteCodable] = []
    
    //MARK: - Initialization
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.fethcNoteList()
    }
    
    //MARK: - Private methods
    private func updateData(for noteList: [NoteCodable]) {
        if let filePath = directoryURL.appendingPathComponent("user") as URL?,
            let encodeData = try? JSONEncoder().encode(noteList) {
            do {
                try encodeData.write(to: filePath)
                print("Succes write data for user")
            } catch {
                print("Error")
            }
        }
    }
    
  
    
    private func fethcNoteList() {
        let localPath = self.directoryURL.appendingPathComponent("user") as URL?
        if let filePath = localPath?.path,
            let data = FileManager.default.contents(atPath: filePath),
            let noteList = try? JSONDecoder().decode([NoteCodable].self, from: data) {
            self.notelist = noteList
        }
    }
    
    
    //MARK: - Publick methods
    func addNote(note: NoteCodable) {
        self.notelist.append(note)
        self.updateData(for: self.notelist)
    }
    
    func getNoteList() -> [NoteCodable] {
        return self.notelist
    }
    
    func removeNote(at index: Int) {
        self.notelist.remove(at: index)
        self.updateData(for: self.notelist)
    }
    
}
