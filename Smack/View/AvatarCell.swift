//
//  AvatarCell.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/26.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}


class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    
    func configureCell(index: Int, type: AvatarType){
        
        if type == AvatarType.dark{
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
            
        }else{
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
            
        }
        
        
    }
    
    
    func setupView(){
        
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        
    }
    
}
