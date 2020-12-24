//
//  ViewController.swift
//  applePie
//
//  Created by eric on 2020/12/23.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
   
    //單字
    var listOfWords = ["buccaneer", "swift", "glorious",
    "incandescent", "bug", "program"]
   
    //答對數量
    var totalWins = 0  {
      didSet {
        newRound()
       }
    }
    
    //答錯數量
    var totalLosses = 0  {
        didSet {
     newRound()
}
    }
    

    let incorrectMovesAllowed = 7
    
    var currentGame: Game!
  
    func newRound() {

      if  listOfWords.isEmpty == false {

        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(_enable: true)
            updateUI()

        }
        else {
            enableLetterButtons(_enable: false)
            if  listOfWords.isEmpty == true {

                listOfWords = ["buccaneer", "swift", "glorious","incandescent", "bug", "program"]

                }

            }

    }

    func enableLetterButtons(_enable: Bool)  {
        
        for button in letterButtons  {
            button.isEnabled = true
            
       }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined (separator:" ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "正解: \(totalWins),誤答: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            
            totalLosses += 1
        
            
        }
        else if currentGame.word == currentGame.formattedWord {
            
            totalWins += 1
           
            
        }
        else {
            updateUI ()
            
        }
    }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter:letter)
        updateGameState()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }


}

