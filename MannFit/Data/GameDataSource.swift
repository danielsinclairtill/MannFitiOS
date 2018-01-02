//
//  GameDataSource.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-23.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class GameDataSource: NSObject, UICollectionViewDataSource {
    
    private lazy var games: [Game] = {
        var games = [Game]()
        let pacman = Game(gameName: GameData.pacmanName, gameImageName: GameData.pacmanImageName, storyboardIdentifier: GameData.pacmanIdentifier)
        
        games.append(pacman)
        
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
