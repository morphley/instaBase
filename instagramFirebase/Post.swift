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
    
    init(dictionary: [String: Any]) {
        
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        
    }

}
