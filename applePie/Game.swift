//
//  Game.swift
//  applePie
//
//  Created by eric on 2020/12/23.
//

import Foundation
import AVFoundation

struct Game {
    var word1: String
    var incorrectMovesRemainingPlayer1: Int
    var guessedPlayer1: [Character]
   
    mutating func player1Guessed (letter: Character) {
        guessedPlayer1.append(letter)
        if !word1.contains(letter){
           incorrectMovesRemainingPlayer1 -= 1
            speek()
          
         }
        
       }
    
    
    func speek(){
           
           let speechUtterance = AVSpeechUtterance(string: "oh oh 猜錯了")
           speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
           speechUtterance.rate = 0.5
           speechUtterance.postUtteranceDelay = 50
           let synthesizer = AVSpeechSynthesizer()
           synthesizer.speak(speechUtterance)
       }
    
    var formattedWord: String  {
        var guessedWord = ""
      
        for letter in word1{
            if guessedPlayer1.contains(letter)  {
                guessedWord += "\(letter)"
            
            }
            else {
                guessedWord += "_"
            }
         }
        
        return guessedWord
    }
    
    
    
}


