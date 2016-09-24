//
//  RestAPIRequestService.swift
//  ChatBot
//
//  Created by Rene Argento on 12/7/15.
//  Copyright © 2015 bepid. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIRequestService {
    
    func getDefaultHeaders() -> [String: String] {
        let defaultHeaders = [
            RestAPIManager.contentTypeHeaderKey: RestAPIManager.applicationJsonHeaderValue,
            RestAPIManager.acceptHeaderKey: RestAPIManager.applicationJsonHeaderValue
        ]
        
        return defaultHeaders
    }
    
    func getStatusCode(_ response: DataResponse<Any>?) -> Int {
        var statusCode = 0
        
        if let httpResponse = response?.response {
            statusCode = httpResponse.statusCode as Int
        }
        
        return statusCode
    }
    
    func generateObjectParameters(_ object : NSObject) -> [String:AnyObject]{
        let mirroredObject = Mirror(reflecting: object)
        
        var requestParameters = [String:AnyObject]()
        
        for (_, attribute) in mirroredObject.children.enumerated() {
            
            if let propertyName = attribute.label as String! {
                
                if let value = object.value(forKey: propertyName) {
                    requestParameters[propertyName] = value as AnyObject?
                }
            }
        }
        print(requestParameters)
        return requestParameters
    }
    
}
