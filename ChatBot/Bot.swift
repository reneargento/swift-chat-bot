//
//  Bot.swift
//  ChatBot
//
//  Created by Rene Argento on 2/3/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

class Bot {
        
    func getUpdates() {
        let restAPIManager = RestAPIManager.restAPIManagerInstance
        let requestURL = "\(Constants.botToken)\(RestAPIManager.getUpdatesUrl)"
        
        let parameters = [String:AnyObject]()
        
        restAPIManager.getRequest(requestURL, parameters: parameters,
            completionHandler: { (data, response, error) -> Void in
                do {
                    
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let messageService = MessageService()
                    
                    let ok = jsonDictionary.valueForKey(RestAPIManager.okKey) as! Bool
                    
                    if(ok){
                        let result = jsonDictionary.valueForKey(RestAPIManager.resultKey) as! NSArray
                        
                        var messageList = messageService.getMessagesFromResponse(result as! [NSDictionary])
                        
                        messageService.orderMessagesBasedOnId(&messageList)
                        let lastMessage = messageList.last
                        
                        if let messageId = lastMessage?.messageId {
                            if messageService.checkIfANewMessageArrived(messageId) {
                                
                                //Store the last message ID read
                                UserDefaultsUtil.writeInt(messageId, key: UserDefaultsUtil.lastMessageIdReadKey)
                                
                                if let lastMessageValue = lastMessage {
                                    self.handleMessage(lastMessageValue)
                                }
                            } else {
                                //No new messages
                            }
                        }
                    } else {
                        print("An exception occurred when getting the messages")
                    }
                } catch {
                    print("An exception occurred when parsing the get messages response")
                }
        })
    }
    
    private func handleMessage(message: Message) {
        var response = BotResponses.defaultResponse
        
        if let text = message.text {
            if text.lowercaseString.rangeOfString(Constants.bestText) != nil
            || text.lowercaseString.rangeOfString(Constants.fkBestText) != nil{
                
                if text.lowercaseString.rangeOfString(Constants.companyText) != nil {
                    response = BotResponses.companyResponse
                } else if text.lowercaseString.rangeOfString(Constants.areaText) != nil {
                    response = BotResponses.areaResponse
                }
            }
        }
        
        sendMessage(response)
    }
    
    private func sendMessage(response: String) {
        let restAPIManager = RestAPIManager.restAPIManagerInstance
        let restAPIRequestService = RestAPIRequestService()
        
        let requestURL = "\(Constants.botToken)\(RestAPIManager.sendMessageUrl)"
        
        var requestParameters = [String:AnyObject]()
        requestParameters[Message.chatIdKey] = Constants.chatId
        requestParameters[Message.textKey] = response
        
        restAPIManager.postRequest(requestURL, parameters: requestParameters) { (data, response, error) -> Void in
            if error == nil {
                let statusCode = restAPIRequestService.getStatusCode(response!)
                
                if statusCode == ResponseEnum.OKResponse.rawValue {
                    print("ChatBot just answered the message!")
                }
            } else {
                print("An exception occurred when sending the message")
            }
        }
    }
    
}
