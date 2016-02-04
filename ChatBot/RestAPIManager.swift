//
//  RestAPIManager.swift
//  ChatBot
//
//  Created by Rene Argento on 11/4/15.
//  Copyright © 2015 bepid. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIManager {
    
    typealias GenericRequestCompletionHandler = (success:Bool, statusCode: Int, error:NSError?) -> Void
    typealias RestAPICompletionHandler = (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void
    
    static let restAPIManagerInstance = RestAPIManager()
    
    //URLs
    static let telegramURL = "https://api.telegram.org/bot"
    static let getUpdatesUrl = "/getUpdates"
    static let sendMessageUrl = "/sendMessage"
    
    //Keys
    static let okKey = "ok"
    static let resultKey = "result"
    static let whereKey = "where"
    
    //Header keys
    static let contentTypeHeaderKey = "Content-Type"
    static let acceptHeaderKey = "Accept"
    
    //Header value - Content Types
    static let applicationJsonHeaderValue = "application/json"
    
    private init() {
        //Singleton
    }
    
    func getRequest(urlPath: String, var parameters: [String:AnyObject]?,
        completionHandler:RestAPIManager.RestAPICompletionHandler) {
        
        let requestURL = String(format: "%@%@", RestAPIManager.telegramURL, urlPath)
        let restAPIRequestService = RestAPIRequestService()
        
        if parameters != nil {
            var whereParameters = [String:AnyObject]()
            
            let data = try! NSJSONSerialization.dataWithJSONObject(parameters!, options: NSJSONWritingOptions(rawValue: 0))
            let jsonParameters = NSString(data: data, encoding: NSUTF8StringEncoding)
            print(jsonParameters)
            whereParameters[RestAPIManager.whereKey] = jsonParameters
            
            parameters = whereParameters
        }
        
        let headers = restAPIRequestService.getDefaultHeaders()
        
        print(requestURL)
        
        Alamofire.request(.GET, requestURL, headers: headers, parameters: parameters)
            .response { request, response, data, error in
                completionHandler(data: data, response: response, error:error)
        }
    }

    
    func postRequest(requestURL: String, parameters: [String:AnyObject],
        contentType: String = RestAPIManager.applicationJsonHeaderValue, completionHandler:RestAPICompletionHandler) {
            
            let requestURL = String(format: "%@%@", RestAPIManager.telegramURL, requestURL)
            print(requestURL)
            let restAPIRequestService = RestAPIRequestService()
            var headers = restAPIRequestService.getDefaultHeaders()
            
            headers[RestAPIManager.contentTypeHeaderKey] = contentType
            
            Alamofire.request(.POST, requestURL, parameters: parameters, headers: headers, encoding: .JSON)
                .response { request, response, data, error in
                    completionHandler(data: data, response: response, error:error)
            }
    }
}