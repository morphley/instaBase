//
//  Users.swift
//  instagramFirebase
//
//  Created by Morphley on 06.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit



struct User {
    
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String : Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String  ?? "" // because its an Any type
        
    }
    
    
}

