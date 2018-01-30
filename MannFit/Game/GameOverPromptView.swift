//
//  GameOverPromptView.swift
//  MannFit
//
//  Created by Daniel Till on 11/26/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class GameOverPromptView: UIView {
    
    weak var delegate: GameOverPromptDelegate?
    private let buttonWidth: CGFloat = 120.0
    private let buttonFontSize: CGFloat = 22.0
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .white
        label.text = "Game Finished"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10.0
        button.setTitle("RESTART", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: buttonFontSize)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10.0
        button.setTitle("EXIT", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: buttonFontSize)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(exitGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30.0
        self.backgroundColor = UIColor.darkGray
        self.translatesAutoresizingMaskIntoConstraints = false
    
        self.addSubview(self.title)
        self.addSubview(self.restartButton)
        self.addSubview(self.exitButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewHeight: CGFloat = 200.0
        let horizontalPadding: CGFloat = 20.0
        
        let titleSize: CGSize = title.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let restartButtonSize: CGSize = restartButton.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let exitButtonSize: CGSize = exitButton.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        
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
    
        NSLayoutConstraint.activate([
            self.restartButton.widthAnchor.constraint(lessThanOrEqualToConstant: buttonWidth),
            self.restartButton.heightAnchor.constraint(equalToConstant: restartButtonSize.height),
            self.restartButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: buttonWidth / 2 + horizontalPadding),
            self.restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            self.restartButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant:  -buttonWidth / 2),
            ])
        
        NSLayoutConstraint.activate([
            self.exitButton.widthAnchor.constraint(lessThanOrEqualToConstant: buttonWidth),
            self.exitButton.heightAnchor.constraint(equalToConstant: exitButtonSize.height),
            self.exitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -buttonWidth / 2 - horizontalPadding),
            self.exitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            self.exitButton.centerYAnchor.constraint(equalTo: self.restartButton.centerYAnchor),
            ])
    }
    
    @objc private func restartGame() {
        self.delegate?.restartGame()
    }
    
    @objc private func exitGame() {
        self.delegate?.exitGame()
    }
}
