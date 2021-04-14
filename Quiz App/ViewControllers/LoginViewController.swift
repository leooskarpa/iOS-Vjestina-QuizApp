//
//  LoginViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 13.04.2021..
//

import Foundation
import UIKit
import PureLayout


class LoginViewController: UIViewController, UITextFieldDelegate{
    
    private var titleLogo: UILabel!
    private var stackView: UIStackView!
    private var username: UITextField!
    private var password: UITextField!
    private var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackground()
        buildViews()
        
        self.username.delegate = self
        self.password.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc
    private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.username.endEditing(true)
        self.password.endEditing(true)
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
        // Title logo
        
        titleLogo = UILabel()
        
        titleLogo.frame = CGRect(x: 0, y: 0, width: 140, height: 32)
        titleLogo.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLogo.font = UIFont(name: "SourceSansPro-Bold", size: 42)
        
        titleLogo.center = self.view.center
        titleLogo.center.x = self.view.center.x
        titleLogo.center.y = self.view.center.y
        
        titleLogo.textAlignment = .center
        titleLogo.text = "PopQuiz"
        
        let parent = self.view!
        parent.addSubview(titleLogo)

        titleLogo.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLogo.autoPinEdge(toSuperviewEdge: .top, withInset: 200)
        
        
        // Stack view for email, pass and submit btn
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        parent.addSubview(stackView)
        
        stackView.autoAlignAxis(toSuperviewAxis: .vertical)
        stackView.autoPinEdge(.top, to:.bottom, of: titleLogo, withOffset: 100)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 32)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 32)
        stackView.autoSetDimension(.height, toSize: 190)
        
        
        // Username / email text field
        
        username = PaddedTextField()
        
        username.frame = CGRect(x: 0, y: 0, width: 311, height: 50)
        username.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        
        username.layer.cornerRadius = username.frame.height / 2
        username.layer.borderWidth = 0
        username.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        username.font = UIFont(name: "SourceSansPro-Regular", size: 40)
        username.textColor = .white
        
        username.returnKeyType = .done
        username.autocapitalizationType = .none
        username.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        stackView.addArrangedSubview(username)
        
        username.autoSetDimension(.height, toSize: username.frame.height)
        
        
        // Password text field
        
        password = PasswordTextField()
        
        password.frame = CGRect(x: 0, y: 0, width: 311, height: 50)
        password.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        
        password.layer.cornerRadius = password.frame.height / 2
        password.layer.borderWidth = 0
        password.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        password.font = UIFont(name: "SourceSansPro-Regular", size: 40)
        password.textColor = .white
        
        password.returnKeyType = .done
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password.isSecureTextEntry = true
        
        stackView.addArrangedSubview(password)
        
        password.autoSetDimension(.height, toSize: password.frame.height)
        
        
        // Button for login
        loginButton = UIButton(type: .system)
        loginButton.frame = CGRect(x: 0, y: 0, width: 331, height: 50)
        
        loginButton.backgroundColor = .lightGray
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        loginButton.setTitleColor(UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 0.6), for: .normal)
        
        loginButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.borderWidth = 0
        
        stackView.addArrangedSubview(loginButton)
        
        loginButton.autoSetDimension(.height, toSize: loginButton.frame.height)
        
        loginButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
    }
    
    @objc
    func logIn() {
        if let email = username.text {
            if let pass = password.text {
                if email != "" && pass != "" {
                    
                    username.text = ""
                    password.text = ""
                    
                    print("email:\t\(email)\npassword:\t\(pass)\n")
                    
                    let dataService = DataService()
                    
                    switch dataService.login(email: email, password: pass) {
                    case .success:
                        makeTabBarController()
                    default:
                        break
                    }
                    
                }
            }
        }
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchToNextTextField(textField)
        return true
    }
    
    private func switchToNextTextField(_ textField: UITextField) {
        switch textField {
        case self.username:
            self.password.becomeFirstResponder()
        default:
            logIn()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case username:
            username.layer.borderWidth = 1
        case password:
            password.layer.borderWidth = 1
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case username:
            username.layer.borderWidth = 0
        case password:
            password.layer.borderWidth = 0
        default:
            return
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if username.text != "" && password.text != "" {
            loginButton.isEnabled = true
            loginButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
            loginButton.setTitleColor(UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 1), for: .normal)
        } else {
            loginButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor
            loginButton.setTitleColor(UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 0.6), for: .normal)
            loginButton.isEnabled = false
        }
    }
    
    
    private func makeTabBarController() {
        let bottomTabBarControl = UITabBarController()
        
        let quizVC = QuizzesViewController()
        let searchVC = SearchViewController()
        let settingVC = SettingsViewController()
        
        quizVC.title = "Quiz"
        searchVC.title = "Search"
        settingVC.title = "Settings"
        
        bottomTabBarControl.setViewControllers([quizVC, searchVC, settingVC], animated: false)
        
        guard let pages = bottomTabBarControl.tabBar.items else {
            return
        }
        
        pages[0].image = UIImage(named: "icons8-stopwatch")
        pages[1].image = UIImage(named: "icons8-search")
        pages[2].image = UIImage(systemName: "gear")
        
        bottomTabBarControl.modalPresentationStyle = .fullScreen
        present(bottomTabBarControl, animated: false)
    }
}


// My classes

class PaddedTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 30)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}


class PasswordTextField: PaddedTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.isSecureTextEntry = true
        self.autocorrectionType = .no
        
        // Hide/show password
        let eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        eyeButton.setImage(UIImage(named: "ic_eye_closed"), for: .normal)
        eyeButton.setImage(UIImage(named: "ic_eye_open"), for: .selected)
        rightView = eyeButton
        rightViewMode = .always
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        
        eyeButton.addTarget(self, action: #selector(showHidePass(_:)), for: .touchUpInside)
    }
    
    @objc
    private func showHidePass(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
}
