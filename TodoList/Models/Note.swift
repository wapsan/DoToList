import UIKit


class Note {

    var tittle: String
    var description: String
    var date: String
    
    init(tittle: String, description: String, date: String) {
        self.tittle = tittle
        self.description = description
        self.date = date
    }
    
    static func createNotesArryay() -> [Note] {
        let noteArray = [Note(tittle: "Buy products", description: "Milk, eggs, orange", date: "08.12.20"),
                         Note(tittle: "Go to gym", description: "Train chest", date: "08.13.20"),
                         Note(tittle: "Help mother at home", description: "_", date: "08.15.20"),
                         Note(tittle: "Learn swift", description: "Constraint programaticaly", date: "08.17.20"),
                         Note(tittle: "Do someting", description: "_", date: "08.18.20")]
        return noteArray
    }
    
}
