//
//  ViewController.swift
//  instagramFirebase
//
//  Created by Morphley on 18.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase


class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        // button.backgroundColor = UIColor.red
        // button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    
    func  handlePlusPhoto(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        
        // set a delegate to imagePickerController
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.delegate = self
    }
    
    
    
    // to figure out what image the user pick. Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        // decide between these two images which one whill be shown
        if  let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if  let originalImage = info["UIImagePickerControllerOriginalImage"]  as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
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
    
    
    let alreadyHaveAccountButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14) , NSForegroundColorAttributeName: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleAlreadyHaveAnAccount), for: .touchUpInside)
        return button
        
    }()
    
    
    func handleAlreadyHaveAnAccount(){
        
       _ =  navigationController?.popViewController(animated: true)
        
        // return value not being used therefore set underscore to get rid of the warning
       
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(alreadyHaveAccountButton)
        
        
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 15)
        

        
        view.backgroundColor = UIColor.white
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
            // use self inside of a completion block
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            // gives you a random string
            let fileName = NSUUID().uuidString
            FIRStorage.storage().reference().child("profile_images").child(fileName).put(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                
                print("Failed to upload a profile image", err)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                print("Succesfully uploaded profile-image", profileImageUrl)
                
                
                
                // Save the username into Firebase datbase
                print("Succesfully created user", user?.uid ?? "")
                
                // Code that registers the username
                let dictionaryValues = ["username" : username, "profileImageUrl" : profileImageUrl ]
                guard let uid = user?.uid else { return }
                let values = [uid : dictionaryValues]
                FIRDatabase.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err {
                        
                        print("Failed to save userinfo into DB", err)
                        return
                    }
                    print("Succesfully saved userinfo to DB")
                    
                    // dont see obselete data start fresh every time you login new
                    
                    guard let mainTabBarController =  UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    
                    mainTabBarController.setupViewControllers()
                    
                    self.dismiss(animated: true, completion: nil)

                    
                })

            })
            
            
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

