//
//  MainTabBarController .swift
//  instagramFirebase
//
//  Created by Morphley on 19.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
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
