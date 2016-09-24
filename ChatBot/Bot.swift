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
                    
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let messageService = MessageService()
                    
                    let ok = jsonDictionary.value(forKey: RestAPIManager.okKey) as! Bool
                    
                    if(ok){
                        let result = jsonDictionary.value(forKey: RestAPIManager.resultKey) as! NSArray
                        
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
    
    
    fileprivate func sendMessage(_ response: String) {
        let restAPIManager = RestAPIManager.restAPIManagerInstance
        let restAPIRequestService = RestAPIRequestService()
        
        let requestURL = "\(Constants.botToken)\(RestAPIManager.sendMessageUrl)"
        
        var requestParameters = [String:AnyObject]()
        requestParameters[Message.chatIdKey] = Constants.chatId as AnyObject?
        requestParameters[Message.textKey] = response as AnyObject?
        
        restAPIManager.postRequest(requestURL, parameters: requestParameters) { (data, response, error) -> Void in
            if error == nil {
                let statusCode = restAPIRequestService.getStatusCode(response!)
                
                if statusCode == ResponseEnum.okResponse.rawValue {
                    print("ChatBot just answered the message!")
                }
            } else {
                print("An exception occurred when sending the message")
            }
        }
    }
    
    fileprivate func handleMessage(_ message: Message) {
        var response = BotResponses.defaultResponse
        
        if let text = message.text {
            if text.lowercased().range(of: Constants.bestText) != nil
                || text.lowercased().range(of: Constants.fkBestText) != nil{
                
                if text.lowercased().range(of: Constants.companyText) != nil {
                    response = BotResponses.companyResponse
                } else if text.lowercased().range(of: Constants.areaText) != nil {
                    response = BotResponses.areaResponse
                }
            }
            
            sendMessage(response)
        }
    }
    
}
