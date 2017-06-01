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
        
    
           textLabel.text = comment?.text
        }
    }
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0 // to wrap next line 
        label.backgroundColor = UIColor.lightGray
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.yellow
        
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 4, paddingLeft: 4, paddingRight: 4, paddingBottom: 4, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
