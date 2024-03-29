//
//  ChannelVC.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/22.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    @IBOutlet weak var tabelView: UITableView!
    
    
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabelView.delegate = self
        tabelView.dataSource = self
        
        
       self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tabelView.reloadData()
            }
        }
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tabelView.reloadData()
                
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        
        setUpUserInfo()
        
    }
    
    @objc func channelLoaded(_ notif: Notification){
        tabelView.reloadData()
        
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
        
        
    }
    
    func setUpUserInfo(){
        if AuthService.instance.isLoggedIn  {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tabelView.reloadData()
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
            
        }else{
            return ChannelCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0{
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tabelView.reloadRows(at: [index], with: .none)
        tabelView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
    }

}
