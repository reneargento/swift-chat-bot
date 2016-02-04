//
//  RestAPIRequestService.swift
//  ChatBot
//
//  Created by Rene Argento on 12/7/15.
//  Copyright © 2015 bepid. All rights reserved.
//

import Foundation

class RestAPIRequestService {
    
    func getDefaultHeaders() -> [String: String] {
        let defaultHeaders = [
            RestAPIManager.contentTypeHeaderKey: RestAPIManager.applicationJsonHeaderValue,
            RestAPIManager.acceptHeaderKey: RestAPIManager.applicationJsonHeaderValue
        ]
        
        return defaultHeaders
    }
    
    func getStatusCode(response: NSURLResponse) -> Int {
        var statusCode = 0
        
        if let httpResponse = response as? NSHTTPURLResponse {
            statusCode = httpResponse.statusCode as Int
        }
        
        return statusCode
    }
    
    func generateObjectParameters(object : NSObject) -> [String:AnyObject]{
        let mirroredObject = Mirror(reflecting: object)
        
        var requestParameters = [String:AnyObject]()
        
        for (_, attribute) in mirroredObject.children.enumerate() {
            
            if let propertyName = attribute.label as String! {
                
                if let value = object.valueForKey(propertyName) {
                    requestParameters[propertyName] = value
                }
            }
        }
        print(requestParameters)
        return requestParameters
    }
    
}
