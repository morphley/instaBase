//
//  SharePhotoController.swift
//  instagramFirebase
//
//  Created by Morphley on 22.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController{
    
    var selectedImage: UIImage? {
    
        didSet{
            
            
            self.imageView.image = selectedImage
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    
    let imageView: UIImageView = {
    
        let iv = UIImageView()
        iv.backgroundColor = UIColor.red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    
    
    }()
    
    
    let textView: UITextView = {
    
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    
    }()
    
    
    fileprivate func setupImageAndTextViews(){
    
    
        let containerView = UIView()
         containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
        
        
        // um unter die navbar zu kommen
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 100)
        containerView.addSubview(imageView)
        
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: nil, bottom: containerView.bottomAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 0, paddingBottom: 8, width: 84, height: 0)
    
        
        
        containerView.addSubview(textView)
        
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    func handleShare(){
    
        print("handleShare")
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
