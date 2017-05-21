//
//  Post.swift
//  instagramFirebase
//
//  Created by Morphley on 01.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import Foundation


struct Post{


    let imageUrl: String?
    let caption: String?
    let user: User?
    
    init(user: User, dictionary: [String: Any]) {
        
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }

}
