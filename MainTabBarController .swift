//
//  MainTabBarController .swift
//  instagramFirebase
//
//  Created by Morphley on 19.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        if FIRAuth.auth()?.currentUser == nil {
        
            // shot if not logged in 
            
            DispatchQueue.main.async {
                
                
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            }
            
            return
        
        }
     
//        let redVc = UIViewController()
//        redVc.view.backgroundColor = UIColor.red

        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        viewControllers = [navController, UIViewController()]
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
       tabBar.tintColor = UIColor.black
        
        
    }
}
