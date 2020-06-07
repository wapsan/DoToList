import UIKit

class Note: NSObject, NSCoding {
    
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
    
    //MARK: - Properties keys structure
    struct PropertyKeys {
        static let  noteTittle = "noteTittle"
        static let noteDescription = "noteDescription"
        static let date = "date"
    }
    
    //MARK: - NSCoding protocol
    func encode(with coder: NSCoder) {
        coder.encode(self.noteTittle, forKey: PropertyKeys.noteTittle)
        coder.encode(self.noteDescription, forKey: PropertyKeys.noteDescription)
        coder.encode(self.date, forKey: PropertyKeys.date)
    }
    
    required init?(coder: NSCoder) {
        self.noteTittle = coder.decodeObject(forKey: PropertyKeys.noteTittle) as! String
        self.noteDescription = coder.decodeObject(forKey: PropertyKeys.noteDescription) as! String
        self.date = coder.decodeObject(forKey: PropertyKeys.date) as! String
    }

}
