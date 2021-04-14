//
//  SearchViewController.swift
//  Quiz App
//
//  Created by Leo Skarpa on 13.04.2021..
//

import Foundation
import UIKit
import PureLayout


class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackground()
        
        let title = UILabel()
        title.font = UIFont(name: "SourceSansPro-Bold", size: 42)
        title.textColor = .white
        title.text = "Work in progress..."
        
        self.view!.addSubview(title)
        title.autoAlignAxis(toSuperviewAxis: .vertical)
        title.autoAlignAxis(toSuperviewAxis: .horizontal)
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
}
