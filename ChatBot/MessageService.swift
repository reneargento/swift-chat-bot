//
//  MessageService.swift
//  ChatBot
//
//  Created by Rene Argento on 2/4/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MessageService {
    
    func getMessagesFromResponse(_ results: [NSDictionary]) -> [Message] {
        var messageList = [Message]()
        
        for index in 0..<results.count{
            let message = Message(dictionary: results[index][GetMessageResponseData.messageKey] as! NSDictionary)
            messageList.append(message)
        }
        return messageList
    }
    
    func orderMessagesBasedOnId(_ messageList: inout [Message]) {
        messageList.sort { $0.messageId! < ($1.messageId!) }
    }
    
    func checkIfANewMessageArrived(_ messageId: Int) -> Bool{
        
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
