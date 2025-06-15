import Foundation

public enum CodableError: Error, Equatable {
    case encodeError(NSError), decodeError(NSError), nullableData, nullableJson
}

public extension Encodable {
    func toJson(excluding keys: [String] = [String]()) -> Result<[String: AnyCodable], CodableError> {
        var jsonObject: Any?
        do {
            let objectData = try JSONEncoder().encode(self)
            jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        } catch {
            return .failure(.encodeError(error as NSError))
        }
        
        guard var json = jsonObject as? [String: Any] else {
            print("Error to encode")
            return .failure(.nullableJson)
        }
        
        keys.forEach { json[$0] = nil }
        
        let codableJson = json.mapValues { AnyCodable($0) }
        
        return .success(codableJson)
    }
}

public extension Decodable {
    static func decoder(
        json: [String:Any] = [String:Any](),
        with id: String? = nil
    ) -> Result<Self, CodableError> {
        
        var json = json
        if id != nil {
            json["id"] = id!
        }
        do {
            let documentData = try JSONSerialization.data(withJSONObject: json, options: [])
            let decodeObject = try JSONDecoder().decode(Self.self, from: documentData)
            return .success(decodeObject)
        } catch {
            return .failure(.decodeError(error as NSError))
        }
        
    }
    
    static func decoder(data: Data?) -> Result<Self, CodableError> {
        guard let data = data else {
            return .failure(.nullableData)
        }
        do {
            let decodeObject
                = try JSONDecoder().decode(Self.self, from: data)
            return .success(decodeObject)
        } catch {
            return .failure(.decodeError(error as NSError))
        }
        
    }
}
