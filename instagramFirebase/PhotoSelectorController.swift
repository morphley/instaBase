//
//  PhotoSelectorController.swift
//  instagramFirebase
//
//  Created by Morphley on 21.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let headerId = "headerId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.yellow
        
        
        setupNavigationButtons()
        
        // register a custom cell
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        // register a custom header 
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
    }
    
    var images =  [UIImage]() // empty uiimage array
    fileprivate func fetchPhotos(){
    
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        let sortDiscriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDiscriptor]
       let allPhotos =  PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        allPhotos.enumerateObjects({ (asset, count, stop) in
            print(asset)
            
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                
                if let image = image {
                self.images.append(image)
                }
                
                if count == allPhotos.count - 1 {
                
                    self.collectionView?.reloadData() // when all photos in the array we call reloadData to modify our cell again
                
                }
               // print(image)
            })
            
        })
        
        
    }
    
    
    // all methods for the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        
        return CGSize(width:  width , height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        //cell.backgroundColor = UIColor.blue // default width und height of 50
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    
    
    
    // all methods for the header 
    
    // renders the head
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header.backgroundColor = UIColor.red // you have to provide a size for the header or it wont render
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return  CGSize(width: width, height: width) // PERFECT square
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
    
    return true
    }
    
    fileprivate func setupNavigationButtons(){
    
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    
    
    }
    
    
    func handleCancel(){
    
    dismiss(animated: true, completion: nil)
    }
    
    
    func handleNext(){
        
        print(123)
    
    }
}






