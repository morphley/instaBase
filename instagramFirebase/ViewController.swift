//
//  ViewController.swift
//  instagramFirebase
//
//  Created by Morphley on 18.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase


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
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    
    func  handleTextInputChange(){
        
        // DIsable the signUpButton when the form is not filled
        // Unwrap plus use of defaiult value
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0  && userNameTextField.text?.characters.count ?? 0 > 0
            && passwordTextField.text?.characters.count ?? 0 > 0
        
        
        if isFormValid{
            // If textfield are filled
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 144, blue: 237)
            return
        } else {
            // If textfields are empty change color to original
            signUpButton.isEnabled = false 
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        // tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)

        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        // tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)

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
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
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
    
    func handleSignUp() {
        
        guard let email = emailTextField.text, email.characters.count  > 0
            else {return}
        
        guard let username = userNameTextField.text, username.characters.count > 0
            else {return}
        
        guard let password = passwordTextField.text, password.characters.count > 0
            else {return}
        
        //        let email = "dummy0@gmail.com"
        //        let password = "123123"
        
        // Try to create a new user
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            
            if let err = error {
                
                print("Failed to create user:" , error)
                return
                
            }
            
            print("Succesfully created user", user?.uid ?? "")
        })
        
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

