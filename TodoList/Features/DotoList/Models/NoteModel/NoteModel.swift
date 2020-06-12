import Foundation

class Note: NSObject, Codable {
 
    //MARK: - Coding keys
    enum CodingKeys: String ,CodingKey {
        case noteTitle
        case noteDescription
        case date
    }
    
    //MARK: - Properties
    var noteTitle: String
    var noteDescription: String
    var date: String
   
    //MARK: - Initialization
    init(title: String, description: String, date: String) {
        self.noteTitle = title
        self.noteDescription = description
        self.date = date
    }
}

