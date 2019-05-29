//
//  CircleImage.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/26.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

@IBDesignable

class CircleImage: UIImageView {

    override func awakeFromNib() {
        
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

}
