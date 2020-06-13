import Foundation

class DateManager {
    
    //MARK: - Singletone propertie
    static let shared = DateManager()
    
    //MARK: - Private properties
    private var dateFormat = "MMM d, HH:mm"
    private var dateFormater = DateFormatter()
    
    //MARK: - Public methods
    func getFormatedStringDate(from date: Date) -> String {
        self.dateFormater.dateFormat = self.dateFormat
        return dateFormater.string(from: date)
    }
}
