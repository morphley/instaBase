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
    
    
    
    var user: User? {
        
        // immediately after we set the username
        didSet{
            
            // Fetch the image
            
            guard let profileImageUrl = user?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            // setupProfileImage()
            usernameLabel.text = user?.username
            setupEditFollowButton()
        }
    }
    
    
    fileprivate func setupEditFollowButton(){
        
        
        guard let currentLoggedInUser = FIRAuth.auth()?.currentUser?.uid
            else { return }
        
        guard let userId = user?.uid
            else { return }
        
        if currentLoggedInUser == userId {
            // Edit Profile logic
            
            editProfileFollowButton.setTitle("Edit Profile ", for: .normal)
            
        } else {
            
            //check if following
            FIRDatabase.database().reference().child("following").child(currentLoggedInUser).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                    
                self.setupUnfollowStyle()
                    
                } else {
                   
                    self.setupFollowStyle()
                }
                
            }, withCancel: { (err) in
                print("Failed to check if following", err)
                
            })
            
            
        }
    }
    
    
    
    
    
    func handleEditProfileOrFollowButton(){
        
        print("Execute Edit profile / follow/ Unfollow logic")
        
        guard let currentLoggedInUser = FIRAuth.auth()?.currentUser?.uid
            else { return }
        
        guard let userId = user?.uid
            else { return }
        
        
        if editProfileFollowButton.titleLabel?.text == "Unfollow" {
        
            FIRDatabase.database().reference().child("following").child(currentLoggedInUser).child(userId).removeValue(completionBlock: { (err, ref) in
                
                
                if let err = err {
                
                print("Failed to unfollow user", err)
                    return
                }
                
                
                print("Succesfully unfollowd user", self.user?.username ?? "")
                
                self.setupFollowStyle()
               
            })
        
            
            
            
        }else {
        
            // Follow logic
            
            let ref = FIRDatabase.database().reference().child("following").child(currentLoggedInUser)
            
            
            let values = [userId: 1]
            
            ref.updateChildValues(values) { (err, ref) in
                
                if let err = err {
                    print("Failed to follow user ", err)
                    return
                }
                
                print("Succesfully followed user", self.user?.username ?? "")
                
                self.setupUnfollowStyle()
            
            }
        
        }
        
       
    }
    
    
    
    
    fileprivate func setupFollowStyle(){
    
    self.editProfileFollowButton.setTitle("Follow", for: .normal)
    self.editProfileFollowButton.backgroundColor =  UIColor.rgb(red: 17, green: 154, blue: 237)
    self.editProfileFollowButton.setTitleColor(UIColor.white, for: .normal)
    self.editProfileFollowButton.layer.borderColor = UIColor.init(white: 0, alpha: 0.2).cgColor
    

    }
    
    func setupUnfollowStyle(){
    
        self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
        self.editProfileFollowButton.backgroundColor = UIColor.white
        self.editProfileFollowButton.setTitleColor(UIColor.black, for: .normal)
        
        
    }
    
    
    
    let profileImageView: CustomImageView = {
        
        let iv = CustomImageView()
        // iv.backgroundColor = UIColor.red
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
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let postLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14) ])
        
        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        // label.text = "11\nposts"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
        
    }()
    
    
    let follwersLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14) ])
        
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let followingLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14) ])
        
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleEditProfileOrFollowButton), for: .touchUpInside)
        return button
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
        
        setupUsernameLabel()
        
        
        setupUserStatsView()
        
        addSubview(editProfileFollowButton)
        
        editProfileFollowButton.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, right: followingLabel.rightAnchor, bottom: nil, paddingTop: 2, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 34)
        
        
    }
    
    
    fileprivate func setupUserStatsView(){
        
        let stackView = UIStackView(arrangedSubviews: [postLabel, follwersLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, bottom: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 50 )
        
    }
    
    
    fileprivate func setupUsernameLabel(){
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: gridButton.topAnchor, paddingTop: 4, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 0)
        
    }
    
    fileprivate func setupBottomToolbar(){
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        
        
        //stackView.backgroundColor = UIColor.red
        
        stackView.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: self.frame.width, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0.5)
        
        
    }
    
    //    fileprivate func setupProfileImage(){
    //
    //
    //
    //        guard let profileImageUrl = user?.profileImageUrl else { return }
    //
    //        guard let url = URL(string: profileImageUrl) else { return }
    //
    //
    //        URLSession.shared.dataTask(with: url) { (data, response, err) in
    //            // when completion  block is called is executed you are in a background thread
    //
    //            // check for the error, then construct the iamge using data
    //
    //            if let err = err {
    //
    //                print("Failed to fetch Profileimage", err)
    //                return
    //            }
    //
    //            //print(data)
    //
    //            guard let data = data else { return }
    //
    //            let image = UIImage(data: data)
    //            // need to go back on the main thread
    //            DispatchQueue.main.async {
    //                self.profileImageView.image = image
    //            }
    //
    //            }.resume() // dataTask need to call resume
    //
    //
    //
    //   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
