//
//  QuizTableViewCell.swift
//  Quiz App
//
//  Created by Leo Skarpa on 14.04.2021..
//

import Foundation
import UIKit
import PureLayout

class QuizTableViewCell: UITableViewCell {
    var quiz: Quiz! {
        didSet {
            switch quiz.category {
            case .sport:
                quizImage.image = UIImage(named: "icons8-trophy")
            case .science:
                quizImage.image = UIImage(named: "icons8-laboratory")
            }
            quizTitle.text = quiz?.title
            quizDescription.text = quiz?.description
            quizLevel = quiz?.level
        }
    }
    
    private let quizImage: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        return imageview
    }()
    
    private let quizTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        return title
    }()
    
    private let quizDescription: UILabel = {
        let desc = UILabel()
        desc.textColor = .white
        desc.textAlignment = .left
        desc.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        return desc
    }()
    
    private var quizLevel: Int!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        
        addSubview(quizImage)
        addSubview(quizTitle)
        addSubview(quizDescription)
        
        
        quizImage.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        quizImage.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        quizImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30)
        quizImage.autoSetDimension(.width, toSize: 75)

        quizTitle.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        quizTitle.autoPinEdge(.leading, to: .trailing, of: quizImage, withOffset: 20)
        quizTitle.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        quizDescription.autoPinEdge(.top, to: .bottom, of: quizTitle, withOffset: 20)
        quizDescription.autoPinEdge(.leading, to: .trailing, of: quizImage, withOffset: 20)
        quizDescription.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

