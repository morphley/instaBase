//
//  ViewController.swift
//  instagramFirebase
//
//  Created by Morphley on 18.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        // button.backgroundColor = UIColor.red
       // button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        // tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        // tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        // tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        // view.addSubview(emailTextField)
        // Layout using Frames
        //        plusPhotoButton.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        //        plusPhotoButton.center = view.center
        
        
        //
        //        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        //        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 140, height: 140)
        
        //
        //        emailTextField.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20).isActive = true
        //        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        //        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        //        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupInputFields()
        
    }
    
    
    fileprivate func  setupInputFields() {
        
        //        let greenView = UIView()
        //        greenView.backgroundColor = UIColor.green
        //
        //
        //        let redView = UIView()
        //        redView.backgroundColor = UIColor.red
        
        //        let blackView = UIView()
        //        blackView.backgroundColor = UIColor.black
        //
        //
        //        let blueView = UIView()
        //        blueView.backgroundColor = UIColor.blue
        //
        //
        //        let brownView = UIView()
        //        brownView.backgroundColor = UIColor.brown
        
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton ])
      //  stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = UIColor.black
        
        
        view.addSubview(stackView)
        
        //        stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20).isActive = true
        //        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        //        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        //        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // use the new anchoring method
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0 , height: 200)
        
        
    }
    
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? , left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor? , bottom: NSLayoutYAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if width != 0 {
            
            
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
            
        }
        
        
        
    }
    
}



