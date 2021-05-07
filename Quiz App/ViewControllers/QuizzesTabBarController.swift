//
//  QuizzesTabBarController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 04.05.2021..
//

import Foundation
import UIKit

class QuizzesTabBarController: UITabBarController {
    var coordinator: MainCoordinator!
    var quizNavigator: QuizCoordinator!
    
    private var quizVC: QuizzesViewController!
    private var settingVC: SettingsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizVC = QuizzesViewController()
        let navVC = MyNavigationController(rootViewController: quizVC)
        quizNavigator = QuizCoordinator(navigator: navVC)
        quizVC.coordinator = quizNavigator
        quizNavigator.start()
        
        settingVC = SettingsViewController()
        
        navVC.title = "Quiz"
        settingVC.title = "Settings"
        
        self.setViewControllers([navVC, settingVC], animated: false)
        
        guard let pages = self.tabBar.items else {
            return
        }
        
        pages[0].image = UIImage(named: "icons8-stopwatch")
        pages[1].image = UIImage(systemName: "gear")
        
        self.modalPresentationStyle = .fullScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingVC.coordinator = self.coordinator
    }
}
