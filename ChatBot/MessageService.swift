//
//  MessageService.swift
//  ChatBot
//
//  Created by Rene Argento on 2/4/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

class MessageService {
    
    func getMessagesFromResponse(results: [NSDictionary]) -> [Message] {
        var messageList = [Message]()
        
        for index in 0..<results.count{
            let message = Message(dictionary: results[index][GetMessageResponseData.messageKey] as! NSDictionary)
            messageList.append(message)
        }
        return messageList
    }
    
    func orderMessagesBasedOnId(inout messageList: [Message]) {
        messageList.sortInPlace { $0.messageId! < ($1.messageId!) }
    }
    
    func checkIfANewMessageArrived(messageId: Int) -> Bool{
        
        var isANewMessage = false
        
        var lastMessageIdRead = UserDefaultsUtil.readValue(UserDefaultsUtil.lastMessageIdReadKey) as? Int
        
        if lastMessageIdRead == nil {
            lastMessageIdRead = 0
        }
        
        if messageId > lastMessageIdRead{
            isANewMessage = true
        }
        
        return isANewMessage
    }
}