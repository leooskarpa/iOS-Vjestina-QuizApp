//
//  QuizzesViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 13.04.2021..
//

import Foundation
import UIKit
import PureLayout

class QuizzesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    weak var coordinator: QuizCoordinator!
    
    private var logoTitle: UILabel!
    private var getQuizzesButton: UIButton!
    private var stack: UIStackView!
    private var quizTable: UITableView!
    private var gottenQuizzes = false
    private var quizzes: [Quiz]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackground()
        
        // Remove title from navigation controller and back button
        self.title = nil
        let backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = .white
        
        // Logo title on top
        logoTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 32))
        logoTitle.text = "PopQuiz"
        logoTitle.font = UIFont(name: "SourceSansPro-Bold", size: 32)
        logoTitle.textColor = .white
        
        let parent = self.view!
        parent.addSubview(logoTitle)
        
        logoTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        logoTitle.autoPinEdge(toSuperviewEdge: .top, withInset: 75)
        
        
        // Get Quizzes button
        getQuizzesButton = UIButton(type: .system)
        getQuizzesButton.frame = CGRect(x: 0, y: 0, width: 331, height: 50)
        getQuizzesButton.backgroundColor = .white
        getQuizzesButton.setTitle("Get Quiz", for: .normal)
        getQuizzesButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        getQuizzesButton.setTitleColor(UIColor(red: 0.23, green: 0.38, blue: 0.53, alpha: 1), for: .normal)
        
        getQuizzesButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75).cgColor
        getQuizzesButton.layer.cornerRadius = getQuizzesButton.frame.height / 2
        getQuizzesButton.layer.borderWidth = 0
        
        parent.addSubview(getQuizzesButton)
        
        getQuizzesButton.autoAlignAxis(toSuperviewAxis: .vertical)
        getQuizzesButton.autoPinEdge(.top, to: .bottom, of: logoTitle, withOffset: 25)
        getQuizzesButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 32)
        getQuizzesButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 32)
        getQuizzesButton.autoSetDimension(.height, toSize: getQuizzesButton.frame.height)
        
        getQuizzesButton.addTarget(self, action: #selector(getQuiz(_:)), for: .touchUpInside)
        
        
        // First time error
        stack = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        stack.alignment = .center
        stack.axis = .vertical
        parent.addSubview(stack)
        
        stack.autoAlignAxis(toSuperviewAxis: .horizontal)
        stack.autoAlignAxis(toSuperviewAxis: .vertical)
        stack.autoSetDimensions(to: CGSize(width: 200, height: 300))
        
        let errorImage = UIImageView()
        let image = UIImage(named: "icons8-circled-x")
        
        errorImage.image = image?.withTintColor(.white)
        stack.addArrangedSubview(errorImage)
        errorImage.autoAlignAxis(toSuperviewAxis: .vertical)
        errorImage.contentMode = .scaleAspectFit
        
        
        let errorTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.85

        errorTitle.attributedText = NSMutableAttributedString(string: "Error", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        errorTitle.font = UIFont(name: "SourceSansPro-Bold", size: 36)
        errorTitle.textColor = .white

        stack.addArrangedSubview(errorTitle)
        errorTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        errorTitle.textAlignment = .center
        
        
        let errorText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        errorText.lineBreakMode = .byWordWrapping
        errorText.numberOfLines = 0
        
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.09

        errorText.attributedText = NSMutableAttributedString(string: "Data can’t be reached.\nPlease try again", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        errorText.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        errorText.textColor = .white
        
        stack.addArrangedSubview(errorText)
        errorText.autoAlignAxis(toSuperviewAxis: .vertical)
        errorText.textAlignment = .center
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
    
    
    // Helper functions
    
    @objc
    func getQuiz(_ button: UIButton) {
        
        if gottenQuizzes {
            return
        }
        
        let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        NetworkService().executeUrlRequest(request) { (result: Result<Quizzes, RequestError>) in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    print("Failed loading quizzes")
                    break
                
                case .success(let results):
                    self.quizzes = results.quizzes
                    self.getQuizzes()
                    break
                }
            }
        }
    }
    
    private func getQuizzes() {
        
        stack.isHidden = true
        gottenQuizzes = true
        
        var num = 0
        
        for quiz in quizzes {
            for question in quiz.questions {
                if question.question.contains("NBA") {
                    num += 1
                }
            }
        }
        
        
        // Fun fact label
        let funFactTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        funFactTitleLabel.attributedText = NSMutableAttributedString(string: "💡 Fun Fact", attributes: [NSAttributedString.Key.kern: 0.29])
        funFactTitleLabel.textColor = .white
        funFactTitleLabel.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        
        let parent = self.view!
        
        parent.addSubview(funFactTitleLabel)
        funFactTitleLabel.autoPinEdge(.top, to: .bottom, of: getQuizzesButton, withOffset: 50)
        funFactTitleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 32)
        funFactTitleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 32)
        
        
        let funFactTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        funFactTextLabel.textColor = .white
        funFactTextLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        funFactTextLabel.numberOfLines = 0
        funFactTextLabel.lineBreakMode = .byWordWrapping
        
        funFactTextLabel.attributedText = NSMutableAttributedString(string: "There are \(num) questions that contain the word “NBA”", attributes: [NSAttributedString.Key.kern: 0.22])
        
        parent.addSubview(funFactTextLabel)
        funFactTextLabel.autoPinEdge(.top, to: .bottom, of: funFactTitleLabel, withOffset: 10)
        funFactTextLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 32)
        funFactTextLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 32)
        
        
        
        // Table view for quizzes
        quizTable = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .insetGrouped)
        
        quizTable.backgroundColor = nil
        quizTable.dataSource = self
        quizTable.delegate = self
        quizTable.showsVerticalScrollIndicator = false
        
        quizTable.register(QuizTableViewCell.self, forCellReuseIdentifier: "cell")
        parent.addSubview(quizTable)
        
        
        quizTable.autoAlignAxis(toSuperviewAxis: .vertical)
        quizTable.autoPinEdge(.top, to: .bottom, of: funFactTextLabel, withOffset: 20)
        quizTable.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        quizTable.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        quizTable.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50)
    }
    
    
    // Table functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return QuizCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        
        for quiz in quizzes {
            if quiz.category == QuizCategory.allCases[section] {
                counter += 1
            }
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuizTableViewCell
        var lastQuiz: Quiz
        
        switch QuizCategory.allCases[indexPath.section] {
        case .sport:
            let list = quizzes.filter({(quiz) -> Bool in
                quiz.category == QuizCategory.sport
            })
            
            lastQuiz = list[indexPath.row]
        case .science:
            let list = quizzes.filter({(quiz) -> Bool in
                quiz.category == QuizCategory.science
            })
            
            lastQuiz = list[indexPath.row]
        }
        
        cell.quiz = lastQuiz
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        
        view.text = QuizCategory.allCases[section].rawValue.capitalized
        view.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        
        switch QuizCategory.allCases[section] {
        case .sport:
            view.textColor = .systemYellow
        case .science:
            view.textColor = .systemGreen
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! QuizTableViewCell
        coordinator.selected(selectedCell.getQuiz())
    }
}
