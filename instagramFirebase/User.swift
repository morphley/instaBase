//
//  Users.swift
//  instagramFirebase
//
//  Created by Morphley on 06.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit



struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String , dictionary: [String : Any]) {
        self.uid = uid 
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String  ?? "" // because its an Any type
        
    }
    
    
}

