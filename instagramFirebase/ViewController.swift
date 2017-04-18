//
//  ViewController.swift
//  instagramFirebase
//
//  Created by Morphley on 18.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let plusPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(plusPhotoButton)
        // Layout using Frames
        plusPhotoButton.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        plusPhotoButton.center = view.center

    
    }




}

