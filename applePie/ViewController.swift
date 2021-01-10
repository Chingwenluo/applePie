//
//  ViewController.swift
//  applePie
//
//  Created by eric on 2020/12/23.
//

import UIKit
import AVFoundation
import Foundation


class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var scoreCalculationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    var listOfWords = ["book", "swift", "apple","peter", "bug", "program", "orange","pen","water","tv","hot","job",]
   
    var guessRight = 0 {
        didSet {
          newRound()
         }
      }
    
    var totalWins = 0  {
      didSet {
        newRound()
       }
    }
    
   
    var totalLosses = 0  {
        didSet {
     newRound()
        }
    }
    
 
    let incorrectMovesAllowedPlayer1 = 7
    var currentGame: Game!
    var game = 0
    var gameTimer:Timer?
    var timerCount = 0
    var totalTime = 0
    var select = 0
    
    
    @objc func timerSet() {
        
        timerCount += 1
        let mins =  timerCount/60
        let seconds = timerCount % 60
        self.timeLabel.text = " 時間 \(String(format:"%.2d", mins)):\(String(format:"%.2d", seconds))"
        totalTime += 1
    }
        
    
    func newRound() {
       
      if  listOfWords.isEmpty == false {
      
        let newWord = listOfWords.removeLast()
        currentGame = Game(word1: newWord, incorrectMovesRemainingPlayer1: incorrectMovesAllowedPlayer1, guessedPlayer1: [])
  
            enableLetterButtons(_enable: true)
        updateUI1()
        }

        
      else {
            enableLetterButtons(_enable: false)

            }

    }

    func enableLetterButtons(_enable: Bool)  {

        for button in letterButtons  {
            button.isEnabled = _enable

       }
    }
    
    func updateUI1() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }

        let wordWithSpacing = letters.joined (separator:" ")

     
        switch select {
        case 0:
            treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemainingPlayer1)")
        case 1:
            treeImageView.image = UIImage(named: "orange \(currentGame.incorrectMovesRemainingPlayer1)")
        case 2:
            treeImageView.image = UIImage(named: "Strawberry \(currentGame.incorrectMovesRemainingPlayer1)")
        default:
            break
        }
    
         
      
        
        
       
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "猜對: \(totalWins),猜錯: \(totalLosses)"
        scoreCalculationLabel.text = "得分: \(guessRight)"
       endgame()

        }
        
    
    func endgame(){
        if totalWins == 5 {
            gameTimer?.invalidate()

            let alert = UIAlertController(title: "花費時間", message: "\(totalTime)秒"  , preferredStyle: .alert)
                    let action = UIAlertAction(title: "結束", style: .default) { (_) in
                    }
                        alert.addAction(action)
                        present(alert, animated: true, completion: nil)
                }
    }
    

    
    func updateGameState() {
        if currentGame.incorrectMovesRemainingPlayer1 == 0 {
            totalLosses += 1
           
        } else if currentGame.incorrectMovesRemainingPlayer1 == 0 {
            
        }  else if currentGame.word1 == currentGame.formattedWord {
           
            totalWins += 1
            guessRight += 10
           
            
        }
        else {
            updateUI1 ()
            
        }
    }
        
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
    
        currentGame.player1Guessed(letter:letter)
        updateGameState()
             
    }
    

    @IBAction func chioseSegmented(_ sender: UISegmentedControl) {
        
        select = sender.selectedSegmentIndex
        switch select {
        case 0:
            treeImageView.image = UIImage(named: "Tree 7")
        case 1:
            treeImageView.image = UIImage(named: "orange 7")
        case 2:
            treeImageView.image = UIImage(named: "Strawberry 7")
        default:
            break
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerSet), userInfo: nil, repeats: true)
       
        newRound()
        // Do any additional setup after loading the view.
    }


}

