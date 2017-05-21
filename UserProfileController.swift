    //
    //  UserProfileController.swift
    //  instagramFirebase
    //
    //  Created by Morphley on 19.04.17.
    //  Copyright © 2017 Morphley. All rights reserved.
    //
    
    import UIKit
    import Firebase
    
    let cellId = "cellId"
    
    class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView?.backgroundColor = UIColor.white
            fetchUser()
            
            collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
            
            collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
            
            setupLogoutButton()
            
           // fetchPosts()
            
            fetchOrderedPost()
            
        }
        
        var posts = [Post]()
        
        fileprivate func fetchOrderedPost(){
            
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            let ref = FIRDatabase.database().reference().child("posts").child(uid)
            
            ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
                
                print(snapshot.key, snapshot.value)
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                
                guard let user = self.user else {return}
                
                let post = Post(user: user, dictionary: dictionary)
                
                self.posts.insert(post, at: 0)
              //  self.posts.append(post)
                
                    
                    self.collectionView?.reloadData()
               
   
                
            }) { (err) in
                print("failed to fetch ordered post",err)
            }
        
        }
        
        
        
        
//        fileprivate func fetchPosts(){
//    
//            guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
//            
//            let ref = FIRDatabase.database().reference().child("posts").child(uid)
//            
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                      print(snapshot.value)
//                
//                
//                guard let dictionaries = snapshot.value as? [String : Any] else { return }
//                
//                dictionaries.forEach({ (key, value) in
//                    print("Key\(key), value \(value)")
//                    
//                    guard let dictionary = value as? [String : Any ] else { return }
//                    let imageUrl = dictionary["imageUrl"] as? String
//                    
//                    print("imageUrl\(imageUrl)")
//                    
//                    let post = Post(dictionary: dictionary)
//                    self.posts.append(post)
//                    
//                    
//                })
//                
//                self.collectionView?.reloadData()
//                
//            }) { (err) in
//                
//                print("Failed to fetch posts:", err)
//            }
//            
//            
//        
//        }
        
        
        
        
        fileprivate func setupLogoutButton(){
        
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
        
        
        }
        
        func handleLogout(){
        
        let alertController = UIAlertController(title: nil , message: nil , preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
               // print("Perform Log out")
                
                do {
                  try FIRAuth.auth()?.signOut()
                    
                    // what happens we need to present some kind of login Controller 
                    
                    let loginController = LoginController()
                    let navController = UINavigationController(rootViewController: loginController)
                    self.present(navController, animated: true, completion: nil)
                    
                } catch let signOutErr {
                 
                    print("Failed to SignOut", signOutErr)
                
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
            
            present(alertController, animated: true, completion: nil )
            
            
            
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return posts.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserProfilePhotoCell
            
            // download image
            cell.post = posts[indexPath.item]
          
            return cell
        }
        
        
        // gives us one in the horizontal line
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            
                            var width = ( view.frame.width - 2 ) / 3
                        return CGSize(width: width , height: width)

            
//
//            if indexPath.row < 3 {
//                
//                var width = ( view.frame.width - 2 ) / 3
//            return CGSize(width: width , height: width)
//                
//            }
//            
//            
//            var width = ( view.frame.width - 2 ) / 3
//            return CGSize(width: width , height: width)

        }
        
        
        
        
        
        override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
            //  header.backgroundColor = UIColor.green
            
            
            //not correct
            //header.addSubview(UIImageView()
            
            header.user = self.user
            return header
        }
        
        
        // You just can render it out until you specify some kind of size for The header
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: view.frame.width, height: 200)
        }
        
        
        
        
        var user: User?
        
        // is only accesbile in this classs
        
        // Fetch user and set the navbar TItle
        fileprivate func fetchUser(){
            
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            
            FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                print(snapshot.value ?? "")
                
                //Cast the snapshot value value is of any type we dont know what kind of value is to kind
                //of access
                // the value you have to cast it
                guard    let dictionary = snapshot.value as? [String : Any] else { return }
                
                //            let profileImageUrl = dictionary["profileImageUrl"] as? String
                //               let userName = dictionary["username"] as? String
                
                self.user = User(dictionary: dictionary)
                
                
                
                self.navigationItem.title = self.user?.username
                self.collectionView?.reloadData() // This executes the size for the header and also the rendering of the header one more time
                
            }) { (err) in
                print("Failed to fetch user", err)
                
                
            }
            
            
        }
        
    }
    
    
    
