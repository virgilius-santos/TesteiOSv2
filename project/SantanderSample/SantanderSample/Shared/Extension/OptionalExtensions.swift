import Foundation

extension Optional {
    func executeInMainThread(completion: @escaping (Wrapped) -> ()) {
        guard let element = self else { return }
        if Thread.isMainThread {
            completion(element)
        } else {
            DispatchQueue.main.async {
                completion(element)
            }
        }
    }
}
