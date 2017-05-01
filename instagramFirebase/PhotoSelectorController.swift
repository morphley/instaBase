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
        
        collectionView?.backgroundColor = UIColor.white
        
        
        setupNavigationButtons()
        
        // register a custom cell
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        // register a custom header
        collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData() // entire collectionview is going to redraw itself
        
        //indexpath first one in the grid
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true) // automatically scrools the grid to the top
    }
    
    
    
    
    var selectedImage: UIImage?
    
    var images =  [UIImage]() // empty uiimage array
    var assets = [PHAsset]()
    
    
    
    
    fileprivate func  assetsFetchOptions() -> PHFetchOptions{
        
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        let sortDiscriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDiscriptor]
        return fetchOptions
        
    }
    
    
    
    fileprivate func fetchPhotos(){
        
        let allPhotos =  PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        
        DispatchQueue.global(qos: .background).async {
            
            allPhotos.enumerateObjects({ (asset, count, stop) in
                print(asset)
                
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            
                            self.selectedImage = image  // Anfangsbild setzen
                        }
                    }
                    
                    if count == allPhotos.count - 1 { // Wenn alle Fotos geladen sind
                        
                        DispatchQueue.main.async {
                            
                            self.collectionView?.reloadData() // when all photos in the array we call reloadData to modify our cell again
                            
                            
                        }
                        
                    }
                    // print(image)
                })
                
            })
            
            
        }
        
        
        
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
    
    var header: PhotoSelectorHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
        
        self.header = header
        header.photoImageView.image = selectedImage
        
        print(header.photoImageView.image?.size)
        // header.backgroundColor = UIColor.red // you have to provide a size for the header or it wont render
        
        
        
        
        let imageManger = PHImageManager.default()
        
        if let selectedImage = selectedImage {
            if let index = self.images.index(of: selectedImage) {
                let selectedAsset = self.assets[index]
                
                let targetSize = CGSize(width: 600, height: 600)
                
                imageManger.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil, resultHandler: { (image, info) in
                    
                    header.photoImageView.image = image
                })
                
                
            }
            
            
        }
        
        
        
        
        
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
        
        let sharePhotoController = SharePhotoController()
        sharePhotoController.selectedImage = header?.photoImageView.image
        navigationController?.pushViewController(sharePhotoController, animated: true)
        
        
    }
}






