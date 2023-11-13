import Foundation
import Network
import KeyChain
import FoundationUtils

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
    func login(_ request: Login.Request) async -> Result<Login.UserAccount, APIError> {
        var body: Data?
        do {
            body = try JSONEncoder().encode(request)
        } catch {
            return .failure(APIError.invalidBody)
        }
        let apiRequest = APIRequest(
            url: "v1/login",
            body: body,
            httpMethod: .post
        )
        let result: Result<Login.UserAccount, APIError> = await self.client.request(apiRequest)
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let userAccount):
            saveLogin(request)
            return .success(userAccount)
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
