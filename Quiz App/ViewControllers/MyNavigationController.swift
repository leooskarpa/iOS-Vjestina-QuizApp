//
//  MyNavigationController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 04.05.2021..
//

import Foundation
import UIKit

class MyNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}

