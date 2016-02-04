//
//  ChatService.swift
//  ChatBot
//
//  Created by Rene Argento on 2/3/16.
//  Copyright © 2016 Rene Argento. All rights reserved.
//

import Foundation

class ChatService : NSObject{
    
    let checkChatRoomSelector = "checkChatRoom"
    let bot = Bot()
    
    func listenForUpdates() {
        let _ = NSTimer.scheduledTimerWithTimeInterval(Constants.secondsToWaitBeforeChecking, target: self, selector: Selector(checkChatRoomSelector), userInfo: nil, repeats: true)
    }
    
    func checkChatRoom() {
        bot.getUpdates()
    }
    
}