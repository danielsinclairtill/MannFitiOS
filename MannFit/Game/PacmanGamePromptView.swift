//
//  PacmanGamePromptView.swift
//  MannFit
//
//  Created by Daniel Till on 1/11/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import UIKit

class PacmanGamePromptView: PreGamePromptView {
    
    struct Game1Step {
        static let one = "Place smartphone on center of plankboard"
        static let two = "Balance on the plankboard in push-up position"
        static let three = "Stay in the path, move the plankboard horizontally to move the player"
    }
    
    private let buttonWidth: CGFloat = 120.0
    private let buttonFontSize: CGFloat = 25.0
    private let iconWidth: CGFloat = 50.0
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .white
        label.text = GameData.pacmanName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // step 1
    private lazy var number1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "one-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var step1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .white
        label.text = Game1Step.one
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Game1Icon1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // step 2
    private lazy var number2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "two-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var step2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .white
        label.text = Game1Step.two
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Game1Icon2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // step 3
    private lazy var number3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "three-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var step3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .white
        label.text = Game1Step.three
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Game1Icon3"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10.0
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: buttonFontSize)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10.0
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: buttonFontSize)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cancelGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30.0
        self.backgroundColor = UIColor.darkGray
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.title)
        
        // step 1
        self.addSubview(self.number1)
        self.addSubview(self.step1)
        self.addSubview(self.icon1)
        
        // step 2
        self.addSubview(self.number2)
        self.addSubview(self.step2)
        self.addSubview(self.icon2)
        
        // step 3
        self.addSubview(self.number3)
        self.addSubview(self.step3)
        self.addSubview(self.icon3)
        
        self.addSubview(self.startButton)
        self.addSubview(self.cancelButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewHeight: CGFloat = 400.0
        let horizontalPadding: CGFloat = 20.0
        let verticalPadding: CGFloat = 20.0
        
        let titleSize: CGSize = title.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let step1Size: CGSize = step1.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let step2Size: CGSize = step2.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let step3Size: CGSize = step3.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))

        
        let startButtonSize: CGSize = startButton.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let cancelButtonSize: CGSize = cancelButton.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.bounds.width),
            self.heightAnchor.constraint(equalToConstant: viewHeight)
            ])
        
        NSLayoutConstraint.activate([
            self.title.widthAnchor.constraint(equalToConstant: titleSize.width),
            self.title.heightAnchor.constraint(equalToConstant: titleSize.height),
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.centerYAnchor.constraint(equalTo: self.topAnchor, constant: titleSize.height / 2 + 20.0),
            ])
        
        
        // step 1
        NSLayoutConstraint.activate([
            self.number1.widthAnchor.constraint(equalToConstant: iconWidth),
            self.number1.heightAnchor.constraint(equalToConstant: iconWidth),
            self.number1.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: iconWidth / 2 + horizontalPadding),
            self.number1.centerYAnchor.constraint(equalTo: self.title.bottomAnchor, constant: iconWidth / 2 + verticalPadding),
            ])
        
        NSLayoutConstraint.activate([
            self.icon1.widthAnchor.constraint(equalToConstant: iconWidth),
            self.icon1.heightAnchor.constraint(equalToConstant: iconWidth),
            self.icon1.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -iconWidth / 2 - horizontalPadding),
            self.icon1.centerYAnchor.constraint(equalTo: self.number1.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            self.step1.heightAnchor.constraint(equalToConstant: step1Size.height),
            self.step1.leadingAnchor.constraint(equalTo: self.number1.trailingAnchor, constant: 10.0),
            self.step1.trailingAnchor.constraint(equalTo: self.icon1.leadingAnchor, constant: -10.0),
            self.step1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.step1.topAnchor.constraint(equalTo: self.number1.topAnchor),
            ])
        
        // step 2
        NSLayoutConstraint.activate([
            self.number2.widthAnchor.constraint(equalToConstant: iconWidth),
            self.number2.heightAnchor.constraint(equalToConstant: iconWidth),
            self.number2.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: iconWidth / 2 + horizontalPadding),
            self.number2.centerYAnchor.constraint(equalTo: self.number1.bottomAnchor, constant: iconWidth / 2 + verticalPadding),
            ])
        
        NSLayoutConstraint.activate([
            self.icon2.widthAnchor.constraint(equalToConstant: iconWidth),
            self.icon2.heightAnchor.constraint(equalToConstant: iconWidth),
            self.icon2.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -iconWidth / 2 - horizontalPadding),
            self.icon2.centerYAnchor.constraint(equalTo: self.number2.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            self.step2.heightAnchor.constraint(equalToConstant: step2Size.height),
            self.step2.leadingAnchor.constraint(equalTo: self.number2.trailingAnchor, constant: 10.0),
            self.step2.trailingAnchor.constraint(equalTo: self.icon2.leadingAnchor, constant: -10.0),
            self.step2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.step2.topAnchor.constraint(equalTo: self.number2.topAnchor),
            ])
        
        // step 3
        NSLayoutConstraint.activate([
            self.number3.widthAnchor.constraint(equalToConstant: iconWidth),
            self.number3.heightAnchor.constraint(equalToConstant: iconWidth),
            self.number3.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: iconWidth / 2 + horizontalPadding),
            self.number3.centerYAnchor.constraint(equalTo: self.number2.bottomAnchor, constant: iconWidth / 2 + verticalPadding),
            ])
        
        NSLayoutConstraint.activate([
            self.icon3.widthAnchor.constraint(equalToConstant: iconWidth),
            self.icon3.heightAnchor.constraint(equalToConstant: iconWidth),
            self.icon3.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -iconWidth / 2 - horizontalPadding),
            self.icon3.centerYAnchor.constraint(equalTo: self.number3.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            self.step3.heightAnchor.constraint(equalToConstant: step3Size.height),
            self.step3.leadingAnchor.constraint(equalTo: self.number3.trailingAnchor, constant: 10.0),
            self.step3.trailingAnchor.constraint(equalTo: self.icon3.leadingAnchor, constant: -10.0),
            self.step3.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.step3.topAnchor.constraint(equalTo: self.number3.topAnchor),
            ])
        
        NSLayoutConstraint.activate([
            self.startButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            self.startButton.heightAnchor.constraint(equalToConstant: startButtonSize.height),
            self.startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: buttonWidth / 2 + horizontalPadding),
            self.startButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant:  -buttonWidth / 2),
            ])
        
        NSLayoutConstraint.activate([
            self.cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            self.cancelButton.heightAnchor.constraint(equalToConstant: cancelButtonSize.height),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -buttonWidth / 2 - horizontalPadding),
            self.cancelButton.centerYAnchor.constraint(equalTo: self.startButton.centerYAnchor),
            ])
    }
    
    @objc private func startGame() {
        self.delegate?.startGame(time: 20.0)
    }
    
    @objc private func cancelGame() {
        self.delegate?.cancelGame()
    }
}

