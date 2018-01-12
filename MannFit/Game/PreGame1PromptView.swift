//
//  PreGame1PromptView.swift
//  MannFit
//
//  Created by Daniel Till on 1/11/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import UIKit

class PreGame1PromptView: PreGamePromptView {
    
    private let buttonWidth: CGFloat = 120.0
    private let buttonFontSize: CGFloat = 25.0
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10.0
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-Heavy", size: buttonFontSize)
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
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-Heavy", size: buttonFontSize)
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
        
        self.addSubview(self.startButton)
        self.addSubview(self.cancelButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewHeight: CGFloat = 500.0
        let horizontalPadding: CGFloat = 20.0
        
        let startButtonSize: CGSize = startButton.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        let cancelButtonSize: CGSize = cancelButton.sizeThatFits(CGSize(width: 100.0, height: CGFloat.greatestFiniteMagnitude))
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.bounds.width),
            self.heightAnchor.constraint(equalToConstant: viewHeight)
            ])
        
        NSLayoutConstraint.activate([
            self.startButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            self.startButton.heightAnchor.constraint(equalToConstant: startButtonSize.height),
            self.startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: buttonWidth / 2 + horizontalPadding),
            self.startButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: 20.0),
            ])
        
        NSLayoutConstraint.activate([
            self.cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            self.cancelButton.heightAnchor.constraint(equalToConstant: cancelButtonSize.height),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -buttonWidth / 2 - horizontalPadding),
            self.cancelButton.centerYAnchor.constraint(equalTo: self.startButton.centerYAnchor),
            ])
    }
    
    @objc private func startGame() {
        self.delegate?.startGame(withTime: 20.0)
    }
    
    @objc private func cancelGame() {
        self.delegate?.cancelGame()
    }
}

