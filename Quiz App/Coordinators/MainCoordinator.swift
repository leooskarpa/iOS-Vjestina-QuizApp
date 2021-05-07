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
    
    func login(_ username: String, _ password: String) {
        switch DataService().login(email: username, password: password){
        case .success:
            print("Username: \(username)\nPassword: \(password)")
            let vc = QuizzesTabBarController()
            vc.coordinator = self
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
        case .error(_,_):
            print("Nope")
        }
    }
    
    func logout() {
        let vc = LoginViewController()
        vc.coordinator = self
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
    
}
