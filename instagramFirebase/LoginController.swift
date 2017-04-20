//
//  LoginController.swift
//  instagramFirebase
//
//  Created by Morphley on 21.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let signUpButton : UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Dont have an account? Sign up", for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    
    }()
    
    func handleShowSignUp(){
        
        let signUpController = SignUpController()
        
       navigationController?.pushViewController(signUpController, animated: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(signUpButton)
        
        signUpButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 15)
    }
    
}
