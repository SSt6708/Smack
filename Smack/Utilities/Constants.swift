//
//  Constants.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/23.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import Foundation




typealias CompletionHandler = (_ Success: Bool) -> ()

//Segue

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let PICK_AVATAR = "AvatarPick"


//User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//colors
let placeHolderColor = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.7972601232)


//notification constants

let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChange")
let NOTIF_CHANNELS_LOADED = Notification.Name("notifChannelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("notifChannelSelected")
let NOTIF_MESSAGE_UPDATE = Notification.Name("notifMessageUpdate")



//web url

let BASE_URL = "https://smackkchatt.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"



//headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToke)",
    "Content-Type": "application/json; charset=utf-8"
    
]
