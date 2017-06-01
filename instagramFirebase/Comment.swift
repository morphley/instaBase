
//
//  Comment.swift
//  instagramFirebase
//
//  Created by Morphley on 01.06.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit



struct Comment{

    let user: User
    let text: String
    let uid: String
    
    
    init( user: User, dictionary: [String:Any] ){
    
        self.user = user
    
    self.text = dictionary["text"] as? String ?? ""
        
    self.uid = dictionary["uid"]  as? String ?? ""
        
        
        
    }

}
