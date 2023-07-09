//
//  Sign.swift
//  RockPaperScissors
//
//  Created by Kader Oral on 7.07.2023.
//

import Foundation
import UIKit

enum Sign {
    case rock
    case paper
    case scissors
    var emoji: UIImage{
        switch self{
        case .rock:
            return UIImage(imageLiteralResourceName: "rock.svg")
        case .paper:
            return UIImage(imageLiteralResourceName: "paper.png")
        case .scissors:
            return UIImage(imageLiteralResourceName: "scissors.png")
        }
    }
}


