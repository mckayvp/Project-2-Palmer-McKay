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
    private var collectionSelection = "collection"
    private var tableSelection = "table"
    
    
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
//        Code here
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
    
    private func checkMatch(inCell templeCardCell: TempleCardCell, at indexPath: IndexPath) {
        print("Checking Delegates")
        print(collectionSelection)
        print(tableSelection)
        if (collectionSelection == tableSelection) {
            print("Match")
            UIView.transition(with: templeCardCell.templeCardView,
                              duration: 1.0,
                              options: .curveEaseInOut,
                              animations: nil,
                              completion: {
                                _ in
                                self.collectionView.deleteItems(at: [indexPath])
            })
            print("Keep Trying")
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

extension TempleViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? TempleCardCell) != nil {
            collectionSelection = cards[indexPath.row].name
            print(collectionSelection)
//            print(templeCardCell)
//            checkMatch(inCell: TempleCardCell, at: [indexPath])
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        let templeImage = UIImage(named: cards[indexPath.row].filename)
        let width = templeImage?.size.width
        let height = templeImage?.size.height
        let templeImageWidth = (width! / height!)  * 120.0

        return CGSize(width: templeImageWidth, height: 120.0)
    }
}


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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(tableView.cellForRow(at: <#T##IndexPath#>) as? TempleTableCell) != nil {
//            print("Table Selction")
//            print(cards[indexPath.row].name)
//        }
//        let currentCell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        tableSelection = cards[indexPath.row].name
        print(tableSelection)
//        checkMatch(inCell: TempleCardCell, at: [indexPath])
    }
}
