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
    
    private var correctGuesses = 0
    private var incorrectGuesses = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewWidth.constant = appView.bounds.width / 4
        toggleViewBtnLabel.title = "Study"
        cards.shuffle()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var appView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var toggleViewBtnLabel: UIBarButtonItem!
    @IBOutlet weak var correctTotal: UILabel!
    @IBOutlet weak var incorrectTotal: UILabel!
    @IBOutlet weak var scoreTotal: UILabel!
    @IBOutlet weak var barView: UIView!
    
    // MARK: - Actions
    
    @IBAction func resetGame(_ sender: UIButton) {
    }
    
    @IBAction func toggleViewBtn(_ sender: UIBarButtonItem) {
//        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        if tableViewWidth.constant > 0 {
            tableViewWidth.constant = 0
            toggleViewBtnLabel.title = "Play"
            setGameMode(true)
            barView.isHidden = true
        } else {
            tableViewWidth.constant = collectionView.bounds.width / 4
            toggleViewBtnLabel.title = "Study"
            setGameMode(false)
            barView.isHidden = false
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
        if (collectionView.cellForItem(at: indexPath) as? TempleCardCell) != nil {
            print(cards[indexPath.row].name)
//            print(templeCardCell)
        }

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
