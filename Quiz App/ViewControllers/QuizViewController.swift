//
//  QuizViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 06.05.2021..
//

import Foundation
import UIKit
import PureLayout
import Kingfisher

class QuizViewController: UIViewController {
    weak var coordinator: QuizCoordinator!
    private var quiz: Quiz?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove title from navigation controller and back button
        self.title = nil
        let backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = .white
        
        loadBackground()
        
        // Navigation Bar Item edit
        let logoTitle = UILabel()
        logoTitle.text = "PopQuiz"
        logoTitle.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        logoTitle.textColor = .white
        
        navigationItem.titleView = logoTitle
        
        buildViews()
    }
    
    func setQuiz(for quiz: Quiz) {
        self.quiz = quiz
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
    
    func buildViews() {
        
        // Main View inside which is gonna be a Stack View
        let mainView = UIView()
        
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.35)
        mainView.layer.cornerRadius = 10
        
        self.view.addSubview(mainView)
        mainView.autoAlignAxis(toSuperviewAxis: .horizontal)
        mainView.autoAlignAxis(toSuperviewAxis: .vertical)
        mainView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        mainView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        
        
        // Quiz title
        let title = UILabel()
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .center
        
        title.text = quiz?.title
        title.font = UIFont(name: "SourceSansPro-Bold", size: 28)
        title.textColor = .white
        
        mainView.addSubview(title)
        title.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        title.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        title.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        
        // Quiz description
        let description = UILabel()
        description.numberOfLines = 0
        description.lineBreakMode = .byWordWrapping
        description.textAlignment = .center
        
        description.text = quiz?.description
        description.font = UIFont(name: "SourceSansPro-Regular", size: 22)
        description.textColor = .white
        
        mainView.addSubview(description)
        description.autoPinEdge(.top, to: .bottom, of: title, withOffset: 20)
        description.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        description.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        
        // Quiz picture
        let url = URL(string: quiz!.imageUrl)
        let image = UIImageView()
        
        URLSession.shared.dataTask(with: url!) {data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    image.image = UIImage(data: data)
                    image.autoSetDimension(.height, toSize: (mainView.bounds.width - 40) / (image.image?.size.width)! * (image.image?.size.height)!)
                }
            }
        }.resume()
        
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        
        mainView.addSubview(image)
        image.autoPinEdge(.top, to: .bottom, of: description, withOffset: 20)
        image.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        image.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        // Start quiz button
        let startButton = UIButton(type: .system)
        
        startButton.backgroundColor = .white
        startButton.setTitle("Start Quiz", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        startButton.setTitleColor(UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 1), for: .normal)
        
        startButton.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        startButton.layer.cornerRadius = 50 / 2
        startButton.layer.borderWidth = 0
        
        mainView.addSubview(startButton)
        startButton.autoSetDimension(.height, toSize: 50)
        startButton.autoPinEdge(.top, to: .bottom, of: image, withOffset: 20)
        startButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        startButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        startButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        
        startButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        
        
        // Fit it all
        mainView.sizeToFit()
    }
    
    @objc
    func startQuiz() {
        coordinator.startQuiz(quiz!)
    }
}

