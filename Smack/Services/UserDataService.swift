//
//  UserDataService.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/25.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import Foundation


class UserDataService{
    static let instance = UserDataService()
    
    private (set) public var id = ""
    private (set) public var avatarColor = ""
    private (set) public var avatarName = ""
    private (set) public var email  = ""
    private (set) public var name = ""
    
    
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String){
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String)->UIColor{
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        
        guard let red = r else  { return defaultColor}
        guard let green = g else  { return defaultColor}
        guard let blue = b else  { return defaultColor}
        guard let alpha = a else  { return defaultColor}
        
        let redFloat = CGFloat(red.doubleValue)
        let greenFloat = CGFloat(green.doubleValue)
        let blueFloat = CGFloat(blue.doubleValue)
        let alphaFloat = CGFloat(alpha.doubleValue)
        
        let newColor = UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
        
        return newColor
        
       
    }
    
    func logoutUser(){
        
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToke = ""
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
}
