//
//  AppCoordinator.swift
//  Quiz App
//
//  Created by Leo Skarpa on 04.05.2021..
//

import Foundation
import UIKit

protocol AppCoordinator : class {
    var childViewControllers: [UIViewController] {get set}
    var navigator: MyNavigationController {get set}
    
    func start()
}
