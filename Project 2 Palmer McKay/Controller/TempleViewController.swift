//
//  MasterViewController.swift
//  Project 2 Palmer McKay
//
//  Created by McKay Palmer on 10/11/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class TempleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let TempleCellIdentifier = "TempleCardCell"
        static let TempleTableIdentifier = "TempleTableCell"
    }
    
    private let alertCorrect = UIAlertController(title: "Correct :)", message: "Keep it up!", preferredStyle: .alert)
    private let alertIncorrect = UIAlertController(title: "Incorrect :(", message: "Try a different combination", preferredStyle: .alert)
    
    // MARK: - Properties
    private var cards = TempleDeck()
    private var originalDeck = TempleDeck()
    
    private var correctGuesses = 0
    private var incorrectGuesses = 0
    private var collectionSelection = "collection"
    private var tableSelection = "table"
    private var collectionRow = -1
    private var tableRow = -1
    private var collectionPath: IndexPath = [-1, -1]
    private var tablePath: IndexPath = [-1, -1]

    
    
    
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var toggleViewBtnLabel: UIBarButtonItem!
    @IBOutlet weak var correctTotal: UILabel!
    @IBOutlet weak var incorrectTotal: UILabel!
    @IBOutlet weak var barView: UIView!
    
    // MARK: - Actions
    
    @IBAction func resetGame(_ sender: UIButton) {
        print("clicked reset")
        cards = originalDeck
        cards.shuffle()
        correctGuesses = 0
        incorrectGuesses = 0
        correctTotal.text = "\(correctGuesses)"
        incorrectTotal.text = "\(incorrectGuesses)"
        animate()
    }
    
    @IBAction func toggleViewBtn(_ sender: UIBarButtonItem) {
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
        
        animate()
      
    }
    
    // MARK: - Helpers
    
    private func animate() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.curveLinear],
                       animations: {
                        self.view.layoutIfNeeded()
                        self.collectionView.reloadData()
                        self.tableView.reloadData()
        })
    }
    
    private func setGameMode(_ isStudyMode: Bool) {
        for i in 0 ..< cards.count {
            cards[i].isStudyMode = isStudyMode
        }
    }
    
    private func correctAlert() {
        // create the alert
        let alert = UIAlertController(title: "Correct!", message: "Keep it up!", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func incorrectAlert() {
        // create the alert
        let alert = UIAlertController(title: "Incorrect", message: "Try a different combination.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
//    private func checkMatch(inCell templeCollectionCell: TempleCardCell, at indexPath: IndexPath) {
//        print(">>>>>>Checking Delegates>>>>>")
//        print("collection selection: \(collectionSelection)")
//        print(collectionRow)
//        print("table selection: \(tableSelection)")
//        print(tableRow)
//        if (collectionSelection == tableSelection) {
//            print("Match")
//            correctAlert()
//            UIView.transition(with: templeCollectionCell.templeCardView,
//                              duration: 1.0,
//                              options: .curveEaseInOut,
//                              animations: nil,
//                              completion: {
//                                _ in
//                                self.cards.remove(at: indexPath.row)
//                                self.collectionView.deleteItems(at: [indexPath])
//                                self.correctGuesses += 1
//                                self.correctTotal.text = "\(self.correctGuesses)"
//                                self.collectionSelection = "collection"
//                                self.tableSelection = "table"
//            })
//
//        } else {
//            incorrectAlert()
//            incorrectGuesses += 1
//            incorrectTotal.text = "\(incorrectGuesses)"
//        }
//    }
    
    private func checkMatch(_ collectionPath: IndexPath, _ tablePath: IndexPath) {
        print(">>>>>>Checking Delegates>>>>>")
        print("collection selection: \(collectionSelection)")
        print(collectionPath)
        print(collectionRow)
        print("table selection: \(tableSelection)")
        print(tablePath)
        print(tableRow)
        
        if (collectionPath[1] >= 0 && tablePath[1] >= 0) {
            // There are selections in both the collection and table views, check for match
            if (collectionSelection == tableSelection) { // Match!
                print("Match")
                correctAlert()
                UIView.transition(with: appView,
                                  duration: 1.0,
                                  options: .curveEaseInOut,
                                  animations: nil,
                                  completion: {
                                    _ in
                                    self.cards.remove(at: self.collectionPath[1])
                                    self.collectionView.deleteItems(at: [self.collectionPath])
                                    self.tableView.deleteRows(at: [tablePath], with: .automatic)
                                    self.correctGuesses += 1
                                    self.correctTotal.text = "\(self.correctGuesses)"
                                    self.collectionSelection = "collection"
                                    self.tableSelection = "table"
                                    self.collectionPath[1] = -1
                                    self.tablePath[1] = -1
                                    print("Self.CollectionPath")
                                    print(self.collectionPath)
                })
                
            } else { // No Match!
                incorrectAlert()
                incorrectGuesses += 1
                incorrectTotal.text = "\(incorrectGuesses)"
                tableView.deselectRow(at: tablePath, animated: true)
                self.collectionSelection = "collection"
                self.tableSelection = "table"
                self.collectionPath[1] = -1
                self.tablePath[1] = -1
            }
        }
    }
    
    // MARK: - Collection View Data Source
    
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
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let templeCollectionCell = (collectionView.cellForItem(at: indexPath) as? TempleCardCell) {
            collectionSelection = cards[indexPath.row].name
            print("***CollectionSelection***")
            print(collectionSelection)
            print(templeCollectionCell)
            print(indexPath)
            print(indexPath.row)
            collectionPath = indexPath
            print("row...")
            print(collectionPath[1])
            collectionRow = indexPath.row
//            checkMatch(inCell: templeCollectionCell, at: indexPath)
            checkMatch(collectionPath, tablePath)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let templeImage = UIImage(named: cards[indexPath.row].filename)
        let width = templeImage?.size.width
        let height = templeImage?.size.height
        let templeImageWidth = (width! / height!)  * 100.0
        
        return CGSize(width: templeImageWidth, height: 100.0)
    }
    
    // MARK: - Table View Data Source
    
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
    
    // MARK: - Table View Delegate
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        tablePath = indexPath
        tableRow = indexPath.row
        
        
        //        if(tableView.cellForRow(at: <#T##IndexPath#>) as? TempleTableCell) != nil {
        //            print("Table Selction")
        //            print(cards[indexPath.row].name)
        //        }
        //        let currentCell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        tableSelection = cards[indexPath.row].name
        print(tableSelection)
        print(collectionSelection)
        checkMatch(collectionPath, tablePath)
//        if (tableSelection == collectionSelection) {
//            tableView.performBatchUpdates({
//                cards.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            })
//        }
        //        checkMatch(inCell: TempleCardCell, at: [indexPath])
    }
}












