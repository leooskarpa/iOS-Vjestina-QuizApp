//
//  MainCoordinator.swift
//  Quiz App
//
//  Created by Leo Skarpa on 04.05.2021..
//

import Foundation
import UIKit

class MainCoordinator : AppCoordinator {
    var childViewControllers = [UIViewController]()
    var navigator = MyNavigationController()
    
    func start() {
        
    }
    
    func login(with user: User) {
        let vc = QuizzesTabBarController(user)
        vc.coordinator = self
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
    
    func logout() {
        let vc = LoginViewController()
        vc.coordinator = self
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
    
}
