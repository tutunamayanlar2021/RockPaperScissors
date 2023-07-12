//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Kader Oral on 7.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,ResultViewControllerDelegate {
    func resetScores() {
        game.resetScores()
        userScoreLabel.text = "You :\(game.userScore)"
        computerScoreLabel.text = "Computer :\(game.computerScore)"
    }
    @IBOutlet var signImages: [UIImageView]!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userScoreLabel: UILabel!
    
    @IBOutlet weak var computerScoreLabel: UILabel!
    
    let guess:[Guess] = [.rock, .paper, .scissors]
    var userChoice: Guess?
    var computerChoice: Guess?
    var gameState: GameState?
    var game = Game()
    var player: AVAudioPlayer?
    var signs: [Sign] = [.rock, .paper, .scissors]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signEmojis = signs.map { $0.emoji }
        
        imageView.image = signEmojis.randomElement()
        imageView.animationImages = signEmojis
        imageView.animationDuration = 1
        for signImage in signImages {
            signImage.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
            signImage.addGestureRecognizer(tapGesture)
        }
        
        
    }

    
    @IBAction func goButtonTap(_ sender: UIButton) {
        imageView.stopAnimating()
        userScoreLabel.text = "You: \(game.userScore)"
        computerScoreLabel.text = "Computer: \(game.computerScore)"
        switch gameState {
        case .win:
            playSound(soundName: "won", ext: "mp3")
        case .lose:
            playSound(soundName: "fail", ext: "mp3")
        case .tie:
            playSound(soundName: "tie", ext: "mp3")
        default:
            break
        }
        if let controller: ResultViewController = storyboard?.instantiateViewController() {
            controller.gameState = gameState
            controller.userChoice = userChoice
            controller.computerChoice = computerChoice
            controller.delegate = self
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            if let index = signImages.firstIndex(of: tappedImageView) {
                let selectedSign = guess[index]
                userChoice = selectedSign
                imageView.startAnimating()
                switch selectedSign {
                case .rock:
                    playSound(soundName: "C", ext: "wav")
                case .paper:
                    playSound(soundName: "E", ext: "wav")
                case .scissors:
                    playSound(soundName: "A", ext: "wav")
                }
                
                
                computerChoice = computerGuess(with: guess)
                gameState = game.determineGameState(userGuess: selectedSign, computerGuess: computerChoice!)
                print("computerChoice \(computerChoice?.rawValue ?? "")")
                print("user \(selectedSign.rawValue)")
                print("Game state: \(gameState?.rawValue ?? "empty")")
            }
        }
    }
    
    
    
    func playSound(soundName: String ,ext: String?) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: ext ) {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("Ses dosyasını çalarken bir hata oluştu: \(error.localizedDescription)")
            }
        } else {
            print("Ses dosyası bulunamadı.")
        }
        
        
    }
    
}
