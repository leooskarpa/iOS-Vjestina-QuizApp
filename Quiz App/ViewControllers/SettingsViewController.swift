//
//  SettingsViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 13.04.2021..
//

import Foundation
import UIKit
import PureLayout


class SettingsViewController: UIViewController {
    var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Username Label
        let usernameLabel = UILabel()
        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont(name: "SourceSansPro-Regular", size: 18)
        
        self.view.addSubview(usernameLabel)
        usernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        usernameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        
        
        // Username
        let username = UILabel()
        username.text = "ios-vjestina@five.agency"
        username.textColor = .white
        username.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        
        self.view.addSubview(username)
        username.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 10)
        username.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        
        
        // Logout button
        let logoutBtn = UIButton()
        logoutBtn.backgroundColor = .lightGray
        logoutBtn.setTitle("Log Out", for: .normal)
        logoutBtn.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        logoutBtn.setTitleColor(UIColor(red: 0.54, green: 0.15, blue: 0.24, alpha: 1), for: .normal)
        
        logoutBtn.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        logoutBtn.layer.cornerRadius = 50 / 2
        logoutBtn.layer.borderWidth = 0
        
        
        self.view.addSubview(logoutBtn)
        logoutBtn.autoSetDimension(.height, toSize: 50)
        logoutBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 200)
        logoutBtn.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        logoutBtn.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        logoutBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc
    func logout() {
        coordinator.logout()
    }
}

