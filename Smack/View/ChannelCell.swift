//
//  ChannelCell.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/27.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //outlets
    @IBOutlet weak var ChannelName: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
    }
    
    
    func configureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        ChannelName.text = "#\(title)"
        ChannelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id{
                ChannelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }

}
