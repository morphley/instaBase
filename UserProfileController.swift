    //
//  UserProfileController.swift
//  instagramFirebase
//
//  Created by Morphley on 19.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase
    
    class UserProfileController: UICollectionViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView?.backgroundColor = UIColor.white
            
            
            fetchUser()
            
            
        }
    
        // is only accesbile in this classs
        fileprivate func fetchUser(){
            
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            
            FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                print(snapshot.value ?? "")
                
                //Cast the snapshot value value is of any type we dont know what kind of value is to kind 
                //of access
                // the value you have to cast it
                guard    let dictionary = snapshot.value as? [String : Any] else { return }
               let userName = dictionary["username"] as? String
                
                  self.navigationItem.title = userName
            }) { (err) in
                print("Failed to fetch user", err)
              

            }
        
        
        }
    
    }
