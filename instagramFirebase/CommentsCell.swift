//
//  CommentsCell.swift
//  instagramFirebase
//
//  Created by Morphley on 01.06.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit


class CommentsCell: UICollectionViewCell {
    
    
    var comment: Comment? {
    
        didSet{
            guard let comment = comment else { return }
//            guard let profileImageUrl = comment.user?.profileImageUrl else { return }
//              guard let username = comment.user?.username else { return }
//            
//            
            let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
            
        
            attributedText.append(NSAttributedString(string: comment.text, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
            
           //textLabel.text = comment.text
            textView.attributedText = attributedText
            
           
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
        }
    }
    
    // use textview to start text from top
    let textView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
      //  label.numberOfLines = 0 // to wrap next line
      //  label.backgroundColor = UIColor.lightGray
        textView.isScrollEnabled = false
        return textView
    }()
    
    let profileImageView: CustomImageView = {
    
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.blue
        return iv
    
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // backgroundColor = UIColor.yellow
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, right: nil, bottom: nil, paddingTop: 8, paddingLeft: 8, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        
        profileImageView.layer.cornerRadius = 40 / 2
        addSubview(textView)
        textView.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 4, paddingLeft: 4, paddingRight: 4, paddingBottom: 4, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
