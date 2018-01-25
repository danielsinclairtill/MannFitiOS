//
//  GameDataSource.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-23.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

enum GameType {
    case Pacman
    case Testing
}

class GameDataSource: NSObject, UICollectionViewDataSource {
    
    private lazy var games: [Game] = {
        var games = [Game]()
        let pacman = Game(gameName: GameData.pacmanName, gameImageName: GameData.pacmanImageName, storyboardIdentifier: GameData.pacmanIdentifier, gameType: .Pacman)
        let test = Game(gameName: GameData.testingName, gameImageName: GameData.testingImageName, storyboardIdentifier: GameData.testingIdentifier, gameType: .Testing)
        
        games.append(pacman)
        games.append(test)
        
        return games
    }()
    
    private let reuseIdentifier = "GameCell"
    
    func object(at indexPath: IndexPath) -> Game {
        return self.games[indexPath.row]
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! GameMenuCell
        
        if let image = self.games[indexPath.item].gameImage {
            cell.imageView.image = image
        }
        
        cell.label.text = self.games[indexPath.item].gameName
        
        return cell
    }
}
