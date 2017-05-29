//
//  SharePhotoController.swift
//  instagramFirebase
//
//  Created by Morphley on 22.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase

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
        iv.backgroundColor = UIColor.white
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
        
        guard let caption = textView.text, caption.characters.count > 0 else { return } // check wheter or not a caption text existss
        print("handleShare")
        
        // try to get the image outside of the image view
        guard let image = selectedImage else { return } // if there is nothing inside selected Image
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // get access to the storage area
        let filename = NSUUID().uuidString          // random string of letters
        
        FIRStorage.storage().reference().child("posts").child(filename).put(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err  {
                
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload data", err)
                return
            }
            
            guard let imageUrl = metadata?.downloadURL()?.absoluteString  else { return }
            
            print("Successfully uploaded post image", imageUrl)
            
            self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
            
        }
    }
    
    
    static    let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
        
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String){
        
        guard let postImage = selectedImage else { return }
        guard let caption = textView.text else { return }
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        
        
        let userPostRef = FIRDatabase.database().reference().child("posts").child(uid)
        let ref =    userPostRef.childByAutoId()
        
        // Cast it because its a heteregenous dcitionary
        let values = ["imageUrl" : imageUrl, "caption" : caption, "imageWidth": postImage.size.width ,
                      "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        
        ref.updateChildValues(values) { (err, ref) in
            
            if let err = err {
                
                print("Faile to save post to DB", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil) // at the beginning enable button so that you cant save multiple times  the post
            
            // 
         
            NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
            
        }
        
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
