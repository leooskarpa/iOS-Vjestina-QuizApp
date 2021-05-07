//
//  QuizCoordinator.swift
//  Quiz App
//
//  Created by Leo Skarpa on 06.05.2021..
//

import Foundation
import UIKit

class QuizCoordinator: AppCoordinator {
    var childViewControllers = [UIViewController]()
    var navigator: MyNavigationController
    
    init(navigator coordinator: MyNavigationController) {
        self.navigator = coordinator
    }
    
    func start() {
    }
    
    func selected(_ quiz: Quiz) {
        let vc = QuizViewController()
        vc.coordinator = self
        vc.setQuiz(for: quiz)
        navigator.pushViewController(vc, animated: true)
    }
    
    func startQuiz(_ quiz: Quiz) {
        let vc = QuestionsViewController(quiz)
        vc.coordinator = self
        navigator.pushViewController(vc, animated: true)
    }
    
    func endQuiz(result: Int, sum: Int) {
        let vc = ResultViewController(result: result, sum: sum)
        vc.coordinator = self
        navigator.pushViewController(vc, animated: true)
    }
    
    func exitQuiz() {
        navigator.popToRootViewController(animated: true)
    }
}
