import Foundation

class DateManager {
    
    //MARK: - Private properties
    private var dateFormat = "MMM d, HH:mm"
    private var dateFormater = DateFormatter()
    
    //MARK: - Properties
    static var shared = DateManager()
    
    //MARK: - Public methods
    func getFormateDate(from date: Date) -> String {
        self.dateFormater.dateFormat = self.dateFormat
        return dateFormater.string(from: date)
    }
}
