//
//  QuestionsViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 07.05.2021..
//

import Foundation
import UIKit
import PureLayout

class QuestionsViewController: UIViewController {
    weak var coordinator: QuizCoordinator!
    private var quiz: Quiz
    private var questions: [Question]!
    private var questionNow: Int = 0
    private var selectedQuestion: UILabel!
    private var progressBar: UIStackView!
    private var questionText: UILabel!
    private var answers = [UIButton]()
    private var result: Int = 0
    
    init(_ quiz: Quiz) {
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
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
        
        
        // Navigation Bar Item edit
        let logoTitle = UILabel()
        logoTitle.text = "PopQuiz"
        logoTitle.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        logoTitle.textColor = .white
        
        navigationItem.titleView = logoTitle
        
        
        loadBackground()
        getQuestions()
        buildViews()
        
        // Start
        progressBar.subviews[questionNow].backgroundColor = UIColor(white: 1, alpha: 0.6)
        
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
    
    private func buildViews() {
        // No. of question and progressbar
        let questionProgressView = UIView()
        
        self.view.addSubview(questionProgressView)
        questionProgressView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        questionProgressView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        questionProgressView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        questionProgressView.autoSetDimension(.height, toSize: 50)
        
        
        // No. of question
        selectedQuestion = UILabel()
        selectedQuestion.text = "\(questionNow + 1)/\(questions.count)"
        selectedQuestion.textColor = .white
        selectedQuestion.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        
        questionProgressView.addSubview(selectedQuestion)
        selectedQuestion.autoPinEdge(toSuperviewEdge: .top)
        selectedQuestion.autoPinEdge(toSuperviewEdge: .leading)
        selectedQuestion.autoPinEdge(toSuperviewEdge: .trailing)
        
        // Progress bar
        progressBar = UIStackView()
        progressBar.axis = .horizontal
        progressBar.distribution = .fillEqually
        
        for _ in 1...questions.count {
            let vc = UIView()
            vc.layer.cornerRadius = 2.5
            vc.autoSetDimension(.height, toSize: 5)
            vc.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
            progressBar.addArrangedSubview(vc)
        }
        
        questionProgressView.addSubview(progressBar)
        progressBar.autoPinEdge(.top, to: .bottom, of: selectedQuestion, withOffset: 10)
        progressBar.autoPinEdge(toSuperviewEdge: .leading)
        progressBar.autoPinEdge(toSuperviewEdge: .trailing)
        
        
        
        // Question text
        questionText = UILabel()
        questionText.text = quiz.questions[questionNow].question
        questionText.textColor = .white
        questionText.font = UIFont(name: "SourceSansPro-Bold", size: 28)
        questionText.numberOfLines = 0
        questionText.lineBreakMode = .byWordWrapping
        questionText.textAlignment = .left
        
        self.view.addSubview(questionText)
        questionText.autoPinEdge(.top, to: .bottom, of: questionProgressView, withOffset: 40)
        questionText.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        questionText.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        
        
        // Answers (buttons)
        let answer1 = UIButton(type: .system)
        
        answer1.backgroundColor = .lightGray
        answer1.setTitle(quiz.questions[questionNow].answers[0], for: .normal)
        answer1.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        answer1.setTitleColor(.white, for: .normal)
        
        answer1.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        answer1.layer.cornerRadius = 60 / 2
        answer1.layer.borderWidth = 0
        
        answer1.autoSetDimension(.height, toSize: 60)
        self.view.addSubview(answer1)
        answer1.autoPinEdge(.top, to: .bottom, of: questionText, withOffset: 40)
        answer1.autoPinEdge(toSuperviewEdge: .leading)
        answer1.autoPinEdge(toSuperviewEdge: .trailing)
        
        answer1.tag = 0
        answer1.addTarget(self, action: #selector(answerClicked(sender:)), for: .touchUpInside)
        
        let answer2 = UIButton(type: .system)
        
        answer2.backgroundColor = .lightGray
        answer2.setTitle(quiz.questions[questionNow].answers[1], for: .normal)
        answer2.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        answer2.setTitleColor(.white, for: .normal)
        
        answer2.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        answer2.layer.cornerRadius = 60 / 2
        answer2.layer.borderWidth = 0
        
        answer2.autoSetDimension(.height, toSize: 60)
        self.view.addSubview(answer2)
        answer2.autoPinEdge(toSuperviewEdge: .leading)
        answer2.autoPinEdge(toSuperviewEdge: .trailing)
        answer2.autoPinEdge(.top, to: .bottom, of: answer1, withOffset: 20)
        
        answer2.tag = 1
        answer2.addTarget(self, action: #selector(answerClicked(sender:)), for: .touchUpInside)
        
        let answer3 = UIButton(type: .system)
        
        answer3.backgroundColor = .lightGray
        answer3.setTitle(quiz.questions[questionNow].answers[2], for: .normal)
        answer3.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        answer3.setTitleColor(.white, for: .normal)
        
        answer3.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        answer3.layer.cornerRadius = 60 / 2
        answer3.layer.borderWidth = 0
        
        answer3.autoSetDimension(.height, toSize: 60)
        self.view.addSubview(answer3)
        answer3.autoPinEdge(toSuperviewEdge: .leading)
        answer3.autoPinEdge(toSuperviewEdge: .trailing)
        answer3.autoPinEdge(.top, to: .bottom, of: answer2, withOffset: 20)
        
        answer3.tag = 2
        answer3.addTarget(self, action: #selector(answerClicked(sender:)), for: .touchUpInside)
        
        let answer4 = UIButton(type: .system)
        
        answer4.backgroundColor = .lightGray
        answer4.setTitle(quiz.questions[questionNow].answers[3], for: .normal)
        answer4.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        answer4.setTitleColor(.white, for: .normal)
        
        answer4.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        answer4.layer.cornerRadius = 60 / 2
        answer4.layer.borderWidth = 0
        
        answer4.autoSetDimension(.height, toSize: 60)
        self.view.addSubview(answer4)
        answer4.autoPinEdge(toSuperviewEdge: .leading)
        answer4.autoPinEdge(toSuperviewEdge: .trailing)
        answer4.autoPinEdge(.top, to: .bottom, of: answer3, withOffset: 20)
        
        answer4.tag = 3
        answer4.addTarget(self, action: #selector(answerClicked(sender:)), for: .touchUpInside)
        
        answers.append(answer1)
        answers.append(answer2)
        answers.append(answer3)
        answers.append(answer4)
        
    }
    
    private func getQuestions() {
        self.questions = quiz.questions
    }
    
    private func nextQuestion() {
        if questionNow == questions.count - 1{
            endQuiz()
        } else {
            questionNow += 1
            changeQuestion()
        }
    }
    
    private func changeQuestion() {
        selectedQuestion.text = "\(questionNow + 1)/\(questions.count)"
        progressBar.subviews[questionNow].backgroundColor = UIColor(white: 1, alpha: 0.6)
        questionText.text = quiz.questions[questionNow].question
        for (i, answer) in quiz.questions[questionNow].answers.enumerated() {
            answers[i].setTitle(answer, for: .normal)
            answers[i].backgroundColor = UIColor(white: 1, alpha: 0.4)
        }
    }
    
    private func endQuiz() {
        coordinator.endQuiz(result: result, sum: questions.count)
    }
    
    @objc
    func answerClicked(sender: UIButton) {
        let rightAnswer = questions[questionNow].correctAnswer
        
        if sender.tag == rightAnswer {
            result += 1
            sender.backgroundColor = .systemGreen
            progressBar.subviews[questionNow].backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
            answers[rightAnswer].backgroundColor = .systemGreen
            progressBar.subviews[questionNow].backgroundColor = .systemRed
        }
        nextQuestion()
    }
    
    @objc
    func exitQuiz() {
        coordinator.exitQuiz()
    }
    
}
