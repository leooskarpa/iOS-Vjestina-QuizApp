//
//  ResultViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 07.05.2021..
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    weak var coordinator: QuizCoordinator!
    private var result: Int
    private var sum: Int
    private var startTime: Date
    private var endTime: Date?
    private var timeElapsed: Double?
    private var quiz: Quiz
    
    init(result: Int, sum: Int, startTime: Date, quiz: Quiz) {
        self.result = result
        self.sum = sum
        self.startTime = startTime
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // End timer
        endTime = Date()
        
        timeElapsed = DateInterval(start: startTime, end: endTime!).duration as Double
        
        print("Time elapsed:\t", timeElapsed!)
        
        // Posting result
        let url = URL(string: "https://iosquiz.herokuapp.com/api/result")
        
        let bodyData = ["quiz_id": quiz.id,
                        "user_id": UserDefaults.standard.value(forKey: "user_id"),
                        "time": timeElapsed,
                        "no_of_correct": result]
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue((UserDefaults.standard.value(forKey: "token") as! String), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        
        
        NetworkService().executeUrlRequest(request) { (result: Result<ResultResponse, RequestError>) in
            switch result {
            case .failure(_):
                print("Can't post result")
                break
            case .success(let str):
                print(str)
                break
            }
        }
        
        
        loadBackground()
        loadViews()
    }
    
    private func loadBackground() {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 818)
        view.backgroundColor = .blue


        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.23, green: 0.38, blue: 0.53, alpha: 1).cgColor,
            UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 1).cgColor
        ]
        
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.95, b: 1.41, c: -1.41, d: -0.41, tx: 2.02, ty: -0.01))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)

        let parent = self.view!
        parent.addSubview(view)
    }
    
    private func loadViews() {
        // Result view
        let resultView = UILabel()
        resultView.text = "\(result)/\(sum)"
        resultView.textColor = .white
        resultView.font = UIFont(name: "SourceSansPro-Bold", size: 72)
        resultView.textAlignment = .center
        
        self.view.addSubview(resultView)
        resultView.autoAlignAxis(toSuperviewAxis: .horizontal)
        resultView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        
        // Exit button
        let exitBtn = UIButton()
        
        exitBtn.backgroundColor = .lightGray
        exitBtn.setTitle("Finish Quiz", for: .normal)
        exitBtn.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        exitBtn.setTitleColor(UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 1), for: .normal)
        
        exitBtn.layer.backgroundColor = UIColor(white: 1, alpha: 1).cgColor
        exitBtn.layer.cornerRadius = 50 / 2
        exitBtn.layer.borderWidth = 0
        
        self.view.addSubview(exitBtn)
        exitBtn.autoSetDimension(.height, toSize: 50)
        exitBtn.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 100)
        exitBtn.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        exitBtn.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        exitBtn.addTarget(self, action: #selector(exitQuiz), for: .touchUpInside)
    }
    
    @objc
    func exitQuiz() {
        coordinator.exitQuiz()
    }
}