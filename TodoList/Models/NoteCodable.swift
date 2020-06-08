
import Foundation

class NoteCodable: NSObject, Codable {
 
    enum CodingKeys: String ,CodingKey {
        case noteTittle
        case noteDescription
        case date
    }
    
    //MARK: - Properties
    var noteTittle: String
    var noteDescription: String
    var date: String
    
    //MARK: - Initialization
    init(tittle: String, description: String, date: String) {
        self.noteTittle = tittle
        self.noteDescription = description
        self.date = date
    }
    
    
}

