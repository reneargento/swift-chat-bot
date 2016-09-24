//
//  UserDefaultsUtil.swift
//  ChatBot
//
//  Created by Rene Argento on 2/4/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

class UserDefaultsUtil {
    
    static let lastMessageIdReadKey = "lastMessageIdRead"
    
    static func writeString(_ value: String, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func writeBool(_ value: Bool, key: String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func writeInt(_ value: Int, key: String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func readValue(_ key:String) -> AnyObject? {
        var value: AnyObject?
        
        let defaults = UserDefaults.standard
        if let storedValue = defaults.value(forKey: key) {
            value = storedValue as AnyObject?
        }
        
        return value
    }
    
    static func deleteValue(_ key: String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
}
