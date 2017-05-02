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
        
        print(post?.imageUrl ?? "" )
            
            guard let imageUrl = post?.imageUrl else { return }
            guard let url = URL(string: imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                if let err = err {
                
                    print("Failed to fetch post image", err)
                    return
                
                }
                guard let imageData = data else { return }
                
                let photoImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                           self.photoImageView.image = photoImage
                }
         
                
            }.resume()
        }
    
    }
    
    
    
    let photoImageView: UIImageView = {
        
        let iv = UIImageView()
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
