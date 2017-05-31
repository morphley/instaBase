//
//  HomeController.swift
//  instagramFirebase
//
//  Created by Morphley on 02.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase


// IOS 9
//let refreshControl = UIRefreshControl() Then you have access to stop the refresh

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
    
    
    let cellId = "cellId"
    
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotificationName, object: nil)
        
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        
        collectionView?.refreshControl = refreshControl
        
        
        setupNavigationItems()
        
        fetchAllPosts()
        
        //        FIRDatabase.fetchUserWithUid(uid: "oasdkisajdiasdisa") { (user) in
        //
        //            self.fetchPostsWithUser(user: user)
        //        }
        
        
        
    }
    
    
    func handleUpdateFeed(){
        
        handleRefresh()
    }
    
    
    func handleRefresh(){
        print("Handling Refresh...")
        
        posts.removeAll()
        fetchAllPosts()
    }
    
    
    fileprivate func fetchAllPosts(){
        fetchPosts()
        fetchFollowingUserIds()
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
            self.collectionView?.refreshControl?.endRefreshing()
            
            guard let dictionaries = snapshot.value as? [String : Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                print("Key\(key), value \(value)")
                
            
                
                guard let dictionary = value as? [String : Any ] else { return }
                print(dictionary)
                
                let imageUrl = dictionary["imageUrl"] as? String
                
                //  let dummyUser = User(dictionary: ["username": "omari"])
                var post = Post(user: user, dictionary: dictionary)
                post.id = key
                
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
    
    
    var cellToReturn: UICollectionViewCell!
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !self.refreshControl.isRefreshing {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
            
            // cell default color is transparent  with default height und width of 50
            
            cell.post = posts[indexPath.item]
            cell.delegate = self
            cellToReturn = cell
            
            
            
        }
        
        return cellToReturn
    }
    
    
    
    // you have to specify the method of the delegate
    
    func didTapComment(post: Post) {
        // to figure out which post we are tapping on 
        print("message coming from HomeController")
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
        print(post.caption)
    }
    
    
   
}
