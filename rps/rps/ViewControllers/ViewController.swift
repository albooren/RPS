//
//  ViewController.swift
//  rps
//
//  Created by Alperen Kişi on 10.08.2020.
//  Copyright © 2020 Alperen Kişi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myRockImageView: UIButton!
    @IBOutlet weak var myPaperImageView: UIButton!
    @IBOutlet weak var myScissorsImageView: UIButton!
    @IBOutlet weak var yourRockImageView: UIImageView!
    @IBOutlet weak var yourPaperImageView: UIImageView!
    @IBOutlet weak var yourScissorsImageView: UIImageView!
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var yourChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var rock = UIImage(named: "emptyRock")
    var paper = UIImage(named: "emptyPaper")
    var scissors = UIImage(named: "emptyScissors")
    
    var invertedRock = UIImage(named: "blueRock")
    var invertedPaper = UIImage(named: "bluePaper")
    var invertedScissors = UIImage(named: "blueScissors")
    
    var myRock = UIImage(named: "redRock")
    var myPaper = UIImage(named: "redPaper")
    var myScissors = UIImage(named: "redScissors")
    
    var moveArray = ["rock", "paper", "scissors"]
    
    var myNumberResultScoreList = [String]()
    var myTextResultScoreList = [String]()
    
    var newMove = ""
    
    var myCurrentScore = 0
    var yourCurrentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForLabel()
        setupForImages()
        choiseLabelAreEmpty()
    
    }
    
    func fetchLastMyScoreList() {
        let userDefaults = UserDefaults.standard
        if let currentNumberResultMyScores = userDefaults.array(forKey: "resultNumberScores") as? [String] {
            myNumberResultScoreList = currentNumberResultMyScores
        }
        if let currentTextResultMyScores = userDefaults.array(forKey: "resultTextScores") as? [String] {
            myTextResultScoreList = currentTextResultMyScores
        }
    }
    
    func choiseLabelAreEmpty() {
        myChoiceLabel.text = " "
        yourChoiceLabel.text = " "
    }
    
    func setupForLabel() {
        yourScore.text = "0"
        myScore.text = "0"
        gameStatusLabel.text = "Seçimini Yap"
        gameStatusLabel.textColor = .black
        yourChoiceLabel.text = " "
        myChoiceLabel.text = " "
    }
    
    func setupForImages() {
        myRockImageView.setImage(rock, for: .normal)
        myPaperImageView.setImage(paper, for: .normal)
        myScissorsImageView.setImage(scissors, for: .normal)
        yourRockImageView.image = rock
        yourPaperImageView.image = paper
        yourScissorsImageView.image = scissors
    }
    
    func popUp(status: String) {
        guard let myScore = myScore.text, let yourScore = yourScore.text else { return }
        let alert = UIAlertController(title: status, message: "\(myScore) - \(yourScore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { (action) in
            if self.myNumberResultScoreList == [] || self.myTextResultScoreList == [] {
                self.fetchLastMyScoreList()
            }
            let userDefaults = UserDefaults.standard
            self.myNumberResultScoreList.append("\(myScore) - \(yourScore)")
            self.myTextResultScoreList.append(status)
            userDefaults.set(self.myNumberResultScoreList, forKey: "resultNumberScores")
            userDefaults.set(self.myTextResultScoreList, forKey: "resultTextScores")
        }))
        self.present(alert, animated: true)
    }
    
    func result() {
        if myScore.text == "3" {
            popUp(status: "Kazandın")
            setupForLabel()
            resetScores()
            setupForImages()
        } else if yourScore.text == "3" {
            popUp(status: "Kaybettin")
            setupForLabel()
            resetScores()
            setupForImages()
        }
    }
    
    func resetScores() {
        yourCurrentScore = 0
        myCurrentScore = 0
        
    }
    
    @IBAction func restartButtonClicked(_ sender: UIBarButtonItem) {
        setupForLabel()
        setupForImages()
        choiseLabelAreEmpty()
        myCurrentScore = 0
        yourCurrentScore = 0
    }
    
    @IBAction func myRockButtonClicked(_ sender: UIButton) {
        setupForImages()
        myRockImageView.setImage(myRock, for: .normal)
        newMove = moveArray.randomElement() ?? ""
        myChoiceLabel.text = "Taş"
        if newMove == "rock" {
            gameStatusLabel.text = "Berabere"
            gameStatusLabel.textColor = .gray
            yourRockImageView.image = invertedRock
            yourChoiceLabel.text = "Taş"
           
        } else if newMove == "paper" {
            yourCurrentScore += 1
            yourScore.text = "\(yourCurrentScore)"
            gameStatusLabel.text = "Kağıt Taşı Sarar"
            gameStatusLabel.textColor = .red
            yourPaperImageView.image = invertedPaper
            yourChoiceLabel.text = "Kağıt"
          
        } else if newMove == "scissors" {
            myCurrentScore += 1
            myScore.text = "\(myCurrentScore)"
            gameStatusLabel.text = "Taş Makası Kırar"
            gameStatusLabel.textColor = .green
            yourScissorsImageView.image = invertedScissors
            yourChoiceLabel.text = "Makas"
           
        }
        result()
    }
    
    @IBAction func myPaperButtonClicked(_ sender: UIButton) {
        setupForImages()
        myPaperImageView.setImage(myPaper, for: .normal)
        newMove = moveArray.randomElement() ?? ""
        myChoiceLabel.text = "Kağıt"
        if newMove == "rock" {
            myCurrentScore += 1
            myScore.text = "\(myCurrentScore)"
            gameStatusLabel.text = "Kağıt Taşı Sarar"
            gameStatusLabel.textColor = .green
            yourRockImageView.image = invertedRock
            yourChoiceLabel.text = "Taş"
        } else if newMove == "paper" {
            gameStatusLabel.text = "Berabere"
            gameStatusLabel.textColor = .gray
            yourPaperImageView.image = invertedPaper
            yourChoiceLabel.text = "Kağıt"
        } else if newMove == "scissors" {
            yourCurrentScore += 1
            yourScore.text = "\(yourCurrentScore)"
            gameStatusLabel.text = "Makas Kağıdı Keser"
            gameStatusLabel.textColor = .red
            yourScissorsImageView.image = invertedScissors
            yourChoiceLabel.text = "Makas"
        }
        result()
    }
    
    @IBAction func myScissorsButtonClicked(_ sender: UIButton) {
        setupForImages()
        myScissorsImageView.setImage(myScissors, for: .normal)
        newMove = moveArray.randomElement() ?? ""
        myChoiceLabel.text = "Makas"
        if newMove == "rock" {
            yourCurrentScore += 1
            yourScore.text = "\(yourCurrentScore)"
            gameStatusLabel.text = "Taş Makası Kırar"
            gameStatusLabel.textColor = .red
            yourRockImageView.image = invertedRock
            yourChoiceLabel.text = "Taş"
        } else if newMove == "paper" {
            myCurrentScore += 1
            myScore.text = "\(myCurrentScore)"
            gameStatusLabel.text = "Makas Kağıdı Keser"
            gameStatusLabel.textColor = .green
            yourPaperImageView.image = invertedPaper
            yourChoiceLabel.text = "Kağıt"
        } else if newMove == "scissors" {
            gameStatusLabel.text = "Berabere"
            gameStatusLabel.textColor = .gray
            yourScissorsImageView.image = invertedScissors
            yourChoiceLabel.text = "Makas"
        }
        result()
    }
}
