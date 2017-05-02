//
//  CustomImageView .swift
//  instagramFirebase
//
//  Created by Morphley on 02.05.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit


class CustomImageView: UIImageView {
    
    var lastUrlUsedToLoadMessage: String?
    
    func loadImage(urlString: String){
        
        lastUrlUsedToLoadMessage = urlString
    
        print("Loading Image ....")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                
                print("Failed to fetch post image", err)
                return
                
            }
          
            //no repeating effect of the images
            if url.absoluteString != self.lastUrlUsedToLoadMessage {
                return
                
            }
            
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            
            }.resume()
    
    
    }
}
