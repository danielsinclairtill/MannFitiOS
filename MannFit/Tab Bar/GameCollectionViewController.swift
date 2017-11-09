//
//  GameCollectionViewController.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-06.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit



class GameCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    private let reuseIdentifier = "GameCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    private lazy var games: [Game] = {
        var games = [Game]()
        let pacman = Game(gameName: "Pacman", gameImageName: "pacmanPlayerOpen")
        
        games.append(pacman)
        
        return games
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - UICollectionViewDataSource
extension GameCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! GameMenuCell
        
        cell.imageView.image = self.games[indexPath.item].gameImage

        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGameSegue", sender: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - padding
        let itemWidth = availableWidth / itemsPerRow
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


