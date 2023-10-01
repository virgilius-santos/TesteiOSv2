import UIKit

final class LoginWorker {
    private let client: APIClient
    private let keychain: KeychainManager
    
    init(client: APIClient, keychain: KeychainManager) {
        self.client = client
        self.keychain = keychain
    }
}

// MARK: Remote Data

extension LoginWorker {
    func login(_ request: Login.Request, completion: @escaping (Result<Login.UserAccount, APIError>) -> ()) {
        var body: Data?
        do {
            body = try JSONEncoder().encode(request)
        } catch {
            completion(.failure(APIError.invalidBody))
            return
        }
        let apiRequest = APIRequest(
            url: "v1/login",
            body: body,
            httpMethod: .post
        )
        client.request(apiRequest) { [weak self] (result: Result<Login.UserAccount, APIError> ) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let userAccount):
                self?.saveLogin(request)
                completion(.success(userAccount))
            }
        }
    }
}

// MARK: Local Data

extension LoginWorker {
    func saveLogin(_ request: Login.Request) {
        keychain.save(request.user, type: .user)
        keychain.save(request.password, type: .password)
    }
    
    func getLastLogin() -> Login.LoginSave {
        let response = Login.LoginSave(
            user: keychain.get(type: .user),
            password: keychain.get(type: .password)
        )
        return response
    }
}

// MARK: Validations

extension LoginWorker {
    func validateId(_ string: String?) -> Bool {
        guard let word = string, word.count >= 3 else {
            return false
        }
        return (word.match(.patternCPF) || word.match(.patternEmail) )
    }
    
    func validatePassword(_ string: String?) -> Bool {
        guard let word = string, word.count >= 3 else {
            return false
        }
        return word.match(.patternPassword)
    }
}
