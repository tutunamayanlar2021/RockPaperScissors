//
//  Guess.swift
//  RockPaperScissors
//
//  Created by Kader Oral on 9.07.2023.
//

import Foundation

enum Guess: String{
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}
func computerGuess(with guess: [Guess])->Guess{
    return guess.randomElement()!
}
