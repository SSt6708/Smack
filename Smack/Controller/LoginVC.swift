//
//  LoginVC.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/23.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    @IBOutlet weak var userNametxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userNametxt.text, userNametxt.text != "" else {return}
        guard let Password = passwordtxt.text, passwordtxt.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: Password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object:nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    
    
    func setUpview(){
        spinner.isHidden = true
        
        userNametxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        
        passwordtxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
    }
    
}
