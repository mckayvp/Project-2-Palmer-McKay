//
//  MasterViewController.swift
//  Project 2 Palmer McKay
//
//  Created by McKay Palmer on 10/11/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let TempleCellIdentifier = "TempleCell"
    }
    
    // MARK: - Properties
    private var cards = TempleDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "aba-nigeria-temple-lds-273999-mobile.jpg")
        print(image as Any)
    }
}


// MARK: - Collection View Data Source 

extension MasterViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.TempleCellIdentifier,
                                                      for: indexPath)
        
        if let templeCell = cell as? TempleCardCell {
            templeCell.templeCardView.card = cards[indexPath.row]
            templeCell.templeCardView.setNeedsDisplay()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
}

// MARK: - Collection View Delegate

extension MasterViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let templeCardCell = collectionView.cellForItem(at: indexPath) as? TempleCardCell {
            print(cards[indexPath.row])
            print(templeCardCell)
        }
    }
}

