//
//  ResponseEnum.swift
//  ChatBot
//
//  Created by Rene Argento on 2/4/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

enum ResponseEnum: Int {
    
    case OKResponse = 200
    case CreatedResponse = 201
    case Error = 400
    
    static let allValues = [OKResponse, CreatedResponse, Error]
    
}