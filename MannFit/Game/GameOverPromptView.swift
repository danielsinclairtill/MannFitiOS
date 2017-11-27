//
//  GameOverPromptView.swift
//  MannFit
//
//  Created by Daniel Till on 11/26/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class GameOverPromptView: UIView {
    
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("RESTART", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-Heavy", size: 10.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("EXIT", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-Heavy", size: 10.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.background)
        self.addSubview(self.restartButton)
        self.addSubview(self.exitButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let mainSreenWidth = self.bounds.size.width
        let mainScreenHeight = self.bounds.size.height
        
        NSLayoutConstraint.activate([
            self.background.widthAnchor.constraint(equalToConstant: mainSreenWidth - 50.0),
            self.background.heightAnchor.constraint(equalToConstant: mainScreenHeight / 3),
            self.background.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.background.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
    
        NSLayoutConstraint.activate([
            self.restartButton.widthAnchor.constraint(equalToConstant: mainSreenWidth - 50.0),
            self.restartButton.heightAnchor.constraint(equalToConstant: mainScreenHeight / 3),
            self.restartButton.centerXAnchor.constraint(equalTo: self.background.centerXAnchor, constant: -self.restartButton.frame.width),
            self.restartButton.centerYAnchor.constraint(equalTo: self.background.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            self.exitButton.widthAnchor.constraint(equalToConstant: mainSreenWidth - 50.0),
            self.exitButton.heightAnchor.constraint(equalToConstant: mainScreenHeight / 3),
            self.exitButton.centerXAnchor.constraint(equalTo: self.background.centerXAnchor, constant: self.exitButton.frame.width),
            self.exitButton.centerYAnchor.constraint(equalTo: self.background.centerYAnchor),
            ])
    }
}
