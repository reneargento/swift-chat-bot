//
//  Message.swift
//  ChatBot
//
//  Created by Rene Argento on 2/4/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

class Message {
    
    static let dateKey = "date"
    static let textKey = "text"
    static let messageIdKey = "message_id"
    
    //Used to send messages
    static let chatIdKey = "chat_id"
    
    var date: Int?
    var text: String?
    var messageId: Int?
    
    convenience init(dictionary: NSDictionary) {
        self.init()
        self.transformArray(dictionary)
    }
    
    func transformArray(dictionary: NSDictionary){
        if let date = dictionary[Message.dateKey] as? Int{
            self.date = date
        }
        
        if let text = dictionary[Message.textKey] as? String{
            self.text = text
        }
        
        if let messageId = dictionary[Message.messageIdKey] as? Int{
            self.messageId = messageId
        }
    }
    
}