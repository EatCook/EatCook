//
//  DataStorage.swift
//  EatCook
//
//  Created by 강신규 on 5/25/24.
//


import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

class DataStorage: ObjectSavable {
    
    static let shared = { DataStorage() }()
    
    func setString(_ value: String, forKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: forKey)
    }
    
    func getString(forKey: String, defaultValue: String = "") -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: forKey) ?? defaultValue
    }
    
    func setBool(_ value: Bool, forKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: forKey)
    }
    
    func getBool(forKey: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: forKey)
    }
   
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let detaults = UserDefaults.standard
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            detaults.set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        let detaults = UserDefaults.standard
        
        guard let data = detaults.data(forKey: forKey) else {
            throw ObjectSavableError.noValue
        }
        
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
    
    func removeAll() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}

class DataStorageKey {
    static let USERNAME = "username"
    static let CODE = "code"
    static let MENU = "menu"
    static let JWT_ACCESS_TOKEN = "access-token"
    static let JWT_REFRESH_TOKEN = "refresh-token"
    static let PUSH_TOKEN = "PushToken"
    static let LOGIN_TIME = "LoginTime"
    static let IS_PERMISSION = "isPermission"
    static let USER_TOKEN = "usertoken"
    static let IS_MARKETING = "isMarketing"
    static let IS_NOTIFICATION = "isNotification"
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}
