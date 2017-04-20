//
//  UserProfileHeader.swift
//  instagramFirebase
//
//  Created by Morphley on 20.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase


class UserProfileHeader: UICollectionViewCell {
    
    // override a couple of methods to start drawing elements inside of your header
    // they dont have viewDidLoad
    
    let profileImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.backgroundColor = UIColor.red
        iv.layer.cornerRadius = 80 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
         // button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
 
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
          button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let usernameLabel: UILabel = {
    
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // backgroundColor = UIColor.blue
        
        //adding subviews to our header
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, right: nil, bottom: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        
        //        profileImageView.layer.cornerRadius = 80/2
        //        profileImageView.clipsToBounds = true
        
     
        setupBottomToolbar()
        addSubview(usernameLabel)
        
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: gridButton.topAnchor, paddingTop: 4, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 0)
        
       // usernameLabel.text = user?.username
        
    }
    
    
    var user: User? {
    
    // immediately after we set the username
        didSet{
            
            // Fetch the image
            
            setupProfileImage()
            

        }
    }
    
    
    fileprivate func setupBottomToolbar(){
    
    let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.backgroundColor = UIColor.red
        
        stackView.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: self.frame.width, height: 50)
    
    }
    
    fileprivate func setupProfileImage(){
        
        
       
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // when completion  block is called is executed you are in a background thread
            
            // check for the error, then construct the iamge using data
            
            if let err = err {
                
                print("Failed to fetch Profileimage", err)
                return
            }
            
            //print(data)
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            // need to go back on the main thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            }.resume() // dataTask need to call resume

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
