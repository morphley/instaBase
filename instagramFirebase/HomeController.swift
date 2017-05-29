//
//  HomeController.swift
//  instagramFirebase
//
//  Created by Morphley on 02.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase




class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        fetchPosts()
        
             fetchFollowingUserIds()
        
        //        FIRDatabase.fetchUserWithUid(uid: "oasdkisajdiasdisa") { (user) in
        //
        //            self.fetchPostsWithUser(user: user)
        //        }
        
        
   
    }
    
    
    
    fileprivate func fetchFollowingUserIds(){
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid
            else { return }
        
        FIRDatabase.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            // print(snapshot.value)
            
            
            guard let userIdsDictionary = snapshot.value as? [String:Any]
                else { return }
            
            userIdsDictionary.forEach({ (key, value) in
                
                FIRDatabase.fetchUserWithUid(uid: key, completion: { (user) in
                    
                    self.fetchPostsWithUser(user: user)
                    
                })
            })
            
        }) { (err) in
            
            print("Failed to fetch following user ids ", err)
        }
        
        
    }
    
    
    
    var posts = [Post]()
    
    fileprivate func fetchPosts(){
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        
        FIRDatabase.fetchUserWithUid(uid: uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
        
    }
    
    
    fileprivate func fetchPostsWithUser(user: User){
        
        let ref = FIRDatabase.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // print(snapshot.value)
            
            guard let dictionaries = snapshot.value as? [String : Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                print("Key\(key), value \(value)")
                
                guard let dictionary = value as? [String : Any ] else { return }
                print(dictionary)
                
                let imageUrl = dictionary["imageUrl"] as? String
                
                //  let dummyUser = User(dictionary: ["username": "omari"])
                let post = Post(user: user, dictionary: dictionary)
                
                self.posts.append(post)
                
            })
            
            self.posts.sort(by: { (p1, p2) -> Bool in
                
                
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            
            print("Failed to fetch posts:", err)
        }
        
    }
    
    
    func setupNavigationItems(){
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        
        
        
        
    }
    
    //Change the size of a cell when implementing the delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 // username and userprofileimageview
        height += view.frame.width
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        
        // cell default color is transparent  with default height und width of 50
        
        cell.post = posts[indexPath.item]
        return cell
        
    }
    
}
