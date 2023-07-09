//
//  GameState.swift
//  RockPaperScissors
//
//  Created by Kader Oral on 7.07.2023.
//

import Foundation
enum GameState: String{
    case win = "You Won"
    case lose = "Computer Won"
    case tie = "Nobody Won"
}
class Game {
    var userScore: Int = 0
    var computerScore: Int = 0
    
    func determineGameState(userGuess: Guess?, computerGuess: Guess) -> GameState {
        guard let userGuess = userGuess else {
            return .tie
        }
        
        if userGuess == computerGuess {
            return .tie
        } else if (userGuess == .rock && computerGuess == .scissors) ||
                    (userGuess == .paper && computerGuess == .rock) ||
                    (userGuess == .scissors && computerGuess == .paper) {
            updateUserScore()
            
            return .win
        } else {
            updateComputerScore()
            return .lose
        }
    }
    
    func updateUserScore() {
        userScore += 1
    }
    
    func updateComputerScore() {
        computerScore += 1
    }
    
    func resetScores(){
        userScore = 0
        computerScore = 0
    }
}
