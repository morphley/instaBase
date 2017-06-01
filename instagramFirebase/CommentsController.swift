//
//  CommentsController.swift
//  InstagramFirebase
//
//  Created by Brian Voong on 4/29/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit
import Firebase

class CommentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var post: Post?
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView?.backgroundColor = .red
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, -50, 0) // wegen inputacessoryview
       collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, -50, 0) // um scroll komplett runter
        
        collectionView?.register(CommentsCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchComments()
    }
    
    
    var comments =  [Comment]() // empty array of comments
    
    fileprivate func fetchComments(){
    
        guard let postId = self.post?.id else { return }
        
        let ref = FIRDatabase.database().reference().child("comments").child(postId)
        
        ref.observe(.childAdded, with: { (snapshot) in
            
           // print(snapshot.value)
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            //print(dictionary)
            
            let comment = Comment(dictionary: dictionary)
            
         //   print(comment.text, comment.uid)
            self.comments.append(comment)
            self.collectionView?.reloadData()
            
            
        }) { (err) in
            print("failed to observe comments")
        }
        
        
        
    
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentsCell
        
        cell.comment = self.comments[indexPath.item]
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        containerView.addSubview(submitButton)
        submitButton.anchor(top: containerView.topAnchor, left: nil, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 12, paddingBottom: 0, width: 50, height: 0)
        
        
        containerView.addSubview(self.commentTextField)
        self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: submitButton.leftAnchor, bottom: containerView.bottomAnchor, paddingTop: 0, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    
        return containerView
    }()
    
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
    }()
    
    func handleSubmit() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        
        print("post id", self.post?.id)
        print("Inserting comment", commentTextField.text ?? "")
        
        let postId = self.post?.id ?? ""
        let values = ["text": commentTextField.text ?? "", "creationDate": Date().timeIntervalSince1970, "uid": uid] as [String: Any]
        
    
        
     //   let ref = FIRDatabase.database().reference().child("comments").child(uid)
        
       
        FIRDatabase.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
            
            if let err = err {
            
                print("Failed to insert comments", err)
                return
            
            }
            
            print("Succesfully inserted comment.")
        }
        
        
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
