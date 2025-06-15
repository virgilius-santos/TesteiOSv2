import Foundation

public extension String {
    static var patternCPF: String = {
        "([0-9]{2}[\\.]?[0-9]{3}[\\.]?[0-9]{3}[\\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\\.]?[0-9]{3}[\\.]?[0-9]{3}[-]?[0-9]{2})"
    }()

    static var patternEmail: String = {
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    }()

    static var patternPassword: String = {
        "^(?=.*[A-Z])(?=.*[!@#$&*])(((?=.*[0-9])|(?=.*[\\w]))).{3,}$"
    }()
    
    func match(_ pattern: String) -> Bool {
        let mutable = NSMutableString(string: self)
        let range: NSRange = NSRange(location: 0, length: count)
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            regex.replaceMatches(in: mutable, range: range, withTemplate: "")
        } catch {
            return false
        }
        return String(mutable).isEmpty
    }
}
