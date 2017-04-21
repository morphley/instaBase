//
//  LoginController.swift
//  instagramFirebase
//
//  Created by Morphley on 21.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    
    let logoContainerVIew: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        
        let logoImageVIew = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageVIew.contentMode = .scaleAspectFill
        // logoImageVIew.backgroundColor = UIColor.red
        view.addSubview(logoImageVIew)
        
        logoImageVIew.anchor(top: nil, left: nil , right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 50)
        
        logoImageVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
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
    
    
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
        
    }()
    
    
    func handleLogin(){
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
            
            
            if let err = err {
                
                print("Failed to sign in with email", err)
                return
            }
            
            print("Succesfully logged back in with user", user?.uid)
            // view has to dismiss and show the tabbarcontroller 
            
            // Damit Login sign up controller vom richtigen user angezeigt werden
            
            guard let mainTabBarController =  UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            
            mainTabBarController.setupViewControllers()
            
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    
    
    func  handleTextInputChange(){
        
        // DIsable the signUpButton when the form is not filled
        // Unwrap plus use of defaiult value
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        
        if isFormValid{
            // If textfield are filled
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 17, green: 144, blue: 237)
            return
        } else {
            // If textfields are empty change color to original
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    
    
    
    
    let dontHaveAnAccountButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14) , NSForegroundColorAttributeName: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleDontHaveAnAccount), for: .touchUpInside)
        return button
        
    }()
    
    
    
    
    func handleDontHaveAnAccount(){
        
        let signUpController = SignUpController()
        
        navigationController?.pushViewController(signUpController, animated: true)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoContainerVIew)
        logoContainerVIew.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 150)
        
        view.backgroundColor = UIColor.white
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(dontHaveAnAccountButton)
        
        dontHaveAnAccountButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 15)
        
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerVIew.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 40, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 140)
        
        
        
    }
    
}

