//
//  ViewController.swift
//  ChatBot
//
//  Created by Rene Argento on 2/3/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatService = ChatService()
        chatService.listenForUpdates()
    }

}

