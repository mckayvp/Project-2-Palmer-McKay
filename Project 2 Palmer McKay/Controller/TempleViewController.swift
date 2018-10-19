//
//  MasterViewController.swift
//  Project 2 Palmer McKay
//
//  Created by McKay Palmer on 10/11/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class TempleViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let TempleCellIdentifier = "TempleCardCell"
        static let TempleTableIdentifier = "TempleTableCell"
    }
    
    // MARK: - Properties
    private var cards = TempleDeck()
    
    // MARK: - Shared Singleton
    class State {
//        static var isStudyMode = true
        static var correctGuesses = 0
        static var totalGuesses = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewWidth.constant = 0
        cards.shuffle()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var toggleViewBtnLabel: UIBarButtonItem!
    
    // MARK: - Actions
    
    @IBAction func toggleViewBtn(_ sender: UIBarButtonItem) {
//        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        if tableViewWidth.constant > 0 {
            tableViewWidth.constant = 0
            toggleViewBtnLabel.title = "Play"
            setGameMode(true)
        } else {
            tableViewWidth.constant = collectionView.bounds.width / 4
            toggleViewBtnLabel.title = "Study"
            setGameMode(false)
        }
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.curveEaseIn],
                       animations: {
                          self.view.layoutIfNeeded()
                       })
      
    }
    
    // MARK: - Helpers
    
    private func setGameMode(_ isStudyMode: Bool) {
        collectionView.reloadData()
        for i in 0 ..< cards.count {
            cards[i].isStudyMode = isStudyMode
        }
    }
}


// MARK: - Collection View Data Source 

extension TempleViewController : UICollectionViewDataSource {
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

extension TempleViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let templeCardCell = collectionView.cellForItem(at: indexPath) as? TempleCardCell {
//            print(cards[indexPath.row])
//            print(templeCardCell)
//        }
//        Do I need this?∫
    }
}

// MARK: - Temple Cell fixed height, dynamic width

//extension TempleViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //Code here
//    }
//}

// MARK: - Table View Data Source

extension TempleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TempleTableIdentifier,
                                                 for: indexPath)
        
        cell.textLabel?.text =  cards[indexPath.row].title
        cell.detailTextLabel?.text = cards[indexPath.row].region
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

}

// MARK: - Table View Delegate

extension TempleViewController: UITableViewDelegate {
//    Do I need?
}
