//
//  UserSearchController.swift
//  instagramFirebase
//
//  Created by Morphley on 21.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    let cellId = "cellId"
    
    lazy var  searchBar: UISearchBar = {
        
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.barTintColor = UIColor.gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        sb.delegate = self
        return sb
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // print(searchText)
        
        if searchText.isEmpty {
            
            self.filteredUsers = self.users
        } else{
            
            self.filteredUsers = self.users.filter { (user) -> Bool in
                
                return user.username.lowercased().contains(searchText.lowercased())
            }
            
        }
        self.collectionView?.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, right: navBar?.rightAnchor, bottom: navBar?.bottomAnchor, paddingTop: 0, paddingLeft: 8, paddingRight: 8, paddingBottom: 0, width: 0, height: 0 )
        
        
        collectionView?.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .onDrag
        
        fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder() // basically hides the keyboard once you select a row
        let user = filteredUsers[indexPath.item]
        print(user.username)
        
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileController.userId = user.uid
        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    var filteredUsers = [User]()
    var users = [User]()
    
    func fetchUsers(){
        
        let ref = FIRDatabase.database().reference().child("users").observe(.value, with: { (snapshot) in
            
            guard let  dictionaries = snapshot.value as? [String:Any] else { return }
            
        
            dictionaries.forEach({ (key, value) in
                if key == FIRAuth.auth()?.currentUser?.uid {
                
                    print("Found myself ommit from list...")
                
                    return
                }
                
                print(key,value)
                
                guard let userDictionary = value as? [String:Any] else { return }
                
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
                
                
                print(user.uid, user.username)
            })
            
            self.users.sort(by: { (u1, u2) -> Bool in
                
                return u1.username.compare(u2.username) == .orderedAscending
            })
            
            
            self.filteredUsers = self.users
            self.collectionView?.reloadData()
            
        }) { (err) in
            
            print("Failed to fetch Users for Search", err)
        }
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserSearchCell
        
        cell.user = filteredUsers[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 66)
    }
    
}
