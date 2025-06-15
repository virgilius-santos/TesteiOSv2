import Foundation

public extension Array {
    subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        indices.contains(index) ? self[index] : defaultValue()
    }
    
    subscript(safeIndex index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
