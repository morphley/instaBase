//
//  UserProfileCell.swift
//  instagramFirebase
//
//  Created by Morphley on 01.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    
    
    var post: Post? {
        didSet{
            
            guard let imageUrl = post?.imageUrl else { return }
            
            photoImageView.loadImage(urlString: imageUrl)
        }
        
    }
    
    
    
    let photoImageView: CustomImageView = {
        
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0 , paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
