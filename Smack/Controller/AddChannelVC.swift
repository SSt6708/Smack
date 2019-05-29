//
//  AddChannelVC.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/27.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //outlets
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var channelDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    @IBAction func closedPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else {return}
        guard let channelDescription = channelDesc.text, channelDesc.text != "" else {return}
        
        SocketService.instance.addChannel(channelName: channelName, channelDesc: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView(){
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        
        bgView.addGestureRecognizer(closeTouch)
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
         channelDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        
        
    }
    
    @objc func closeTap(_ recgonizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
}
