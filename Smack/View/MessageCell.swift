//
//  MessageCell.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/28.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

   //Outlets
    @IBOutlet weak var UserImg: CircleImage!
    @IBOutlet weak var UserNamelbl: UILabel!
    @IBOutlet weak var timeStamplbl: UILabel!
    @IBOutlet weak var messageBodylbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Messages){
        UserImg.image = UIImage(named: message.userAvatar)
        UserImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        UserNamelbl.text = message.userName
        messageBodylbl.text = message.message
        
    }

}
