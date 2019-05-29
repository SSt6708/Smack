//
//  SocketService.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/27.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit
import SocketIO


class SocketService: NSObject {

    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init(){
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        
        
        super.init()
        
        
    }
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    
    
    func addChannel(channelName: String, channelDesc: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDesc)
        completion(true)
    }
    
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelID = dataArray[2] as? String else {return}
            
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userID: String, channelId: String, completion: @escaping CompletionHandler){
        
        let user = UserDataService.instance
        
        socket.emit("newMessage", messageBody, userID, channelId, user.name, user.avatarName, user.avatarColor)
        
        completion(true)
    }
    
    
    func getChatMessage(completion: @escaping CompletionHandler){
        
        socket.on("messageCreated") { (dataArray, ack) in
            
            guard let msgboddy = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                let newMsg = Messages(message: msgboddy, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMsg)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers:[String: String])->Void) {
    
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String:String] else {return}
            completionHandler(typingUsers)
        }
        
    }
    
    
}
