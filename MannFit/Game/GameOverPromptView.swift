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
        button.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.background)
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
    }
}
