//
//  MessageService.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/26.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class MessageService{
    static let instance = MessageService()
    
    
    var channels = [Channel]()
    var messages = [Messages]()
    var unreadChannels = [String]()
    var selectedChannel : Channel?
    
    
    func findAllChannel(completion: @escaping CompletionHandler){
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                if let json = JSON(data:data).array{
                    
                    for item in json{
                        let name = item["name"].stringValue
                        let channelDiscription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDiscription, id: id)
                        
                        self.channels.append(channel)
                    }
                    
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
                
            }else{
                print("fuck error")
                completion(false)
                debugPrint(response.result.error as Any)
                
            }
            
        }
        
        
    }
    
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                
                if let json = JSON(data: data).array{
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        self.messages.append(Messages(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp))
                    }
                    print("get message success!")
                    completion(true)
                }
                
                
                
            }else{
                print("fail to get message rip")
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
            
            
            
        }
        
    }
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func clearChannels(){
        channels.removeAll()
    }
}
