import Foundation

public extension Formatter {
    
    static var utc: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()
    
}

public extension String {
    
    func toDate(format: DateFormatterString) -> Date {
        let dateFormatter = Formatter.utc
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self) ?? .init()
    }
}

public extension Date {
    func toString(format: DateFormatterString) -> String {
        let dateFormatter = Formatter.utc
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

public enum DateFormatterString: String {
    case apiDate = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case displayDate = "dd/MM/yyyy"
}
