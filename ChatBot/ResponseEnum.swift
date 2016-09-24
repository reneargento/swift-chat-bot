//
//  ResponseEnum.swift
//  ChatBot
//
//  Created by Rene Argento on 2/4/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

enum ResponseEnum: Int {
    
    case okResponse = 200
    case createdResponse = 201
    case error = 400
    
    static let allValues = [okResponse, createdResponse, error]
    
}
