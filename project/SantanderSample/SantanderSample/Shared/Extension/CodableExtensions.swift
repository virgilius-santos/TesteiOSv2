import Foundation

enum CodableError: Error, Equatable {
    case encodeError(NSError), decodeError(NSError), nullableData, nullableJson
}

extension Encodable {
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        var jsonObject: Any?
        do {
            let objectData = try JSONEncoder().encode(self)
            jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        } catch {
            throw CodableError.encodeError(error as NSError)
        }
        
        guard var json = jsonObject as? [String: Any] else {
            print("Error to encode")
            throw CodableError.nullableJson
        }
        
        keys.forEach { json[$0] = nil }
        
        return json
    }
}

extension Decodable {
    static func decoder(
        json: [String:Any] = [String:Any](),
        with id: String? = nil
    ) throws -> Self {
        
        var json = json
        if id != nil {
            json["id"] = id!
        }
        do {
            let documentData = try JSONSerialization.data(withJSONObject: json, options: [])
            let decodeObject = try JSONDecoder().decode(Self.self, from: documentData)
            return decodeObject
        } catch {
            throw CodableError.decodeError(error as NSError)
        }
        
    }
    
    static func decoder(data: Data?) throws -> Self {
        guard let data = data else {
            throw CodableError.nullableData
        }
        
        do {
            let decodeObject
                = try JSONDecoder().decode(Self.self, from: data)
            return decodeObject
        } catch {
            throw CodableError.decodeError(error as NSError)
        }
        
    }
}
