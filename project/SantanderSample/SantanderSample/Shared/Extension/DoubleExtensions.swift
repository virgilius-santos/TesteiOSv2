import Foundation

extension Double {
    var currency: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let str = formatter.string(from: NSNumber(value: self*1000)) {
            return str
        }
        return nil
    }
}
