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
    
    static func writeString(value: String, key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: key)
    }
    
    static func writeBool(value: Bool, key: String)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: key)
    }
    
    static func writeInt(value: Int, key: String)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: key)
    }
    
    static func readValue(key:String) -> AnyObject? {
        var value: AnyObject?
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let storedValue = defaults.valueForKey(key) {
            value = storedValue
        }
        
        return value
    }
    
    static func deleteValue(key: String)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(key)
    }
    
}