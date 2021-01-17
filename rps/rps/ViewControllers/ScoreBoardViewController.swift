//
//  ScoreBoardViewController.swift
//  rps
//
//  Created by Alperen Kişi on 21.08.2020.
//  Copyright © 2020 Alperen Kişi. All rights reserved.
//

import UIKit

class ScoreBoardViewController: UIViewController {

    @IBOutlet weak var scoreTableView: UITableView!
    
    var currentNumberScoreList = [String]()
    var currentTextScoreList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForTableView()
        fetchResultMyScores()
    }
    
    @IBAction func trashClicked(_ sender: UIBarButtonItem) {
        currentTextScoreList.removeAll()
        currentNumberScoreList.removeAll()
        scoreTableView.reloadData()
        let userDefaults = UserDefaults.standard
        userDefaults.set([], forKey: "resultNumberScores")
        userDefaults.set([], forKey: "resultTextScores")
    }
    
    func fetchResultMyScores() {
        let userDefaults = UserDefaults.standard
        if let currentNumberResultMyScores = userDefaults.array(forKey: "resultNumberScores") as? [String] {
            currentNumberScoreList = currentNumberResultMyScores
        }
        if let currentTextResultMyScores = userDefaults.array(forKey: "resultTextScores") as? [String] {
            currentTextScoreList = currentTextResultMyScores
        }
        scoreTableView.reloadData()
    }
    
    func setupForTableView() {
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
    }
}

extension ScoreBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNumberScoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreBoardTableViewCell") as? ScoreBoardTableViewCell {
            cell.numberScoreLabel.text = currentNumberScoreList[indexPath.row]
            cell.resultScoreLabel.text = currentTextScoreList[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentNumberScoreList.remove(at: indexPath.row)
            currentTextScoreList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let userDefaults = UserDefaults.standard
            userDefaults.set(currentNumberScoreList, forKey: "resultNumberScores")
            userDefaults.set(currentTextScoreList, forKey: "resultTextScores")
        }
    }
}
