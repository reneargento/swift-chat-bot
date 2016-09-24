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
    
    typealias GenericRequestCompletionHandler = (_ success:Bool, _ statusCode: Int, _ error:NSError?) -> Void
    typealias RestAPICompletionHandler = (_ data: Data?, _ response: DataResponse<Any>?, _ error:NSError?) -> Void
    
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
    
    fileprivate init() {
        //Singleton
    }
    
    func getRequest(_ urlPath: String, parameters: [String:AnyObject]?,
        completionHandler:@escaping RestAPIManager.RestAPICompletionHandler) {
        var parameters = parameters
        
        let requestURL = String(format: "%@%@", RestAPIManager.telegramURL, urlPath)
        let restAPIRequestService = RestAPIRequestService()
        
        if parameters != nil {
            var whereParameters = [String:AnyObject]()
            
            let data = try! JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions(rawValue: 0))
            let jsonParameters = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(jsonParameters)
            whereParameters[RestAPIManager.whereKey] = jsonParameters
            
            parameters = whereParameters
        }
        
        let headers = restAPIRequestService.getDefaultHeaders()
        
        print(requestURL)
        
        Alamofire.request(requestURL, parameters: parameters, headers: headers)
            .responseJSON { response in
                completionHandler(response.data, response, response.result.error as NSError?)
        }
    }

    
    func postRequest(_ requestURL: String, parameters: [String:AnyObject],
        contentType: String = RestAPIManager.applicationJsonHeaderValue, completionHandler:@escaping RestAPICompletionHandler) {
            
            let requestURL = String(format: "%@%@", RestAPIManager.telegramURL, requestURL)
            print(requestURL)
            let restAPIRequestService = RestAPIRequestService()
            var headers = restAPIRequestService.getDefaultHeaders()
            
            headers[RestAPIManager.contentTypeHeaderKey] = contentType
            
        Alamofire.request(requestURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    completionHandler(response.data, response, response.result.error as NSError?)
            }
    }
}
