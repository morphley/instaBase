//
//  FirebaseUtils.swift
//  instagramFirebase
//
//  Created by Morphley on 21.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase

extension FIRDatabase {
    
    static func fetchUserWithUid(uid: String, completion: @escaping (User) -> () ){
        
        print("Fetching user with uid:", uid)
        
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }

            
            let user = User.init(uid: uid, dictionary: userDictionary)
            
            completion(user)
            //      self.fetchPostsWithUser(user: user)
            
        }) { (err) in
            print("Failed to fetch user for posts:", err)
        }
        
    }
    
}

