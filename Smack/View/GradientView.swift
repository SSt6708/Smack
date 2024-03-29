//
//  GradientView.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/23.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    
    @IBInspectable var topColor: UIColor = UIColor.blue{
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green{
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
