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
        
        setupViewControllers()
        
        //        let redVc = UIViewController()
        //        redVc.view.backgroundColor = UIColor.red
        
        
    }
    
    
    func  setupViewControllers(){
        
        //home
        
        
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        
        
        //Search
        
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
        
        
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        
        //userProfile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        
        
        userProfileController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = UIColor.black
    
        viewControllers = [ homeNavController ,
                            searchNavController,
                            plusNavController,
                            likeNavController,
                            userProfileNavController]
        
        // viewControllers = [navController, UIViewController()]
        
        
        // modify tabbaritem insets
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            
            item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        
        }
        
        
        
        
    }
    
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
    
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    
    }
    
    
    
    
    
    
}
