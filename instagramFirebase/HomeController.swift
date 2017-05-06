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
        
    }
    
    var posts = [Post]()
    
    fileprivate func fetchPosts(){
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        
        let ref = FIRDatabase.database().reference().child("posts").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            
            
            guard let dictionaries = snapshot.value as? [String : Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                print("Key\(key), value \(value)")
                
                guard let dictionary = value as? [String : Any ] else { return }
                let imageUrl = dictionary["imageUrl"] as? String
                
                print("imageUrl\(imageUrl)")
                
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
                
                
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
        
        return CGSize(width: view.frame.width, height: 200)
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
