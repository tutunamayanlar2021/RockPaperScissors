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
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scissorsImage: UIImageView!
    
    @IBOutlet weak var paperImage: UIImageView!
    
    @IBOutlet weak var rockImage: UIImageView!
    
    @IBOutlet weak var userScoreLabel: UILabel!
    
    @IBOutlet weak var computerScoreLabel: UILabel!
    
    let guess:[Guess] = [.rock, .paper, .scissors]
    var userChoice: Guess?
    var computerChoice: Guess?
    var gameState: GameState?
    var game = Game()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signs: [Sign] = [.rock, .paper, .scissors]
        let signImages = signs.map { $0.emoji }
        
        imageView.image = signImages.randomElement()
        imageView.animationImages = signImages
        imageView.animationDuration = 1
        rockImage.isUserInteractionEnabled = true
        paperImage.isUserInteractionEnabled = true
        scissorsImage.isUserInteractionEnabled = true
        
        let rockTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        rockImage.addGestureRecognizer(rockTapGesture)
        
        let paperTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        paperImage.addGestureRecognizer(paperTapGesture)
        
        let scissorsTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        scissorsImage.addGestureRecognizer(scissorsTapGesture)
        

    }
    
    
    @IBAction func goButtonTap(_ sender: UIButton) {
        imageView.stopAnimating()
        userScoreLabel.text = "You :\(game.userScore)"
        computerScoreLabel.text = "Computer :\(game.computerScore)"
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
            
            switch tappedImageView {
            case rockImage:
                userChoice = .rock
                imageView.startAnimating()
                playSound(soundName: "C",ext: "wav")
                
            case paperImage:
                userChoice = .paper
                imageView.startAnimating()
                playSound(soundName: "E",ext: "wav")
            case scissorsImage:
                userChoice = .scissors
                imageView.startAnimating()
                playSound(soundName: "A",ext: "wav")
            default:
                userChoice = nil
            }
            if let userChoice = userChoice {
                computerChoice = computerGuess(with: guess)
                gameState = game.determineGameState(userGuess: userChoice, computerGuess: computerChoice!)
                print("computerChoice \(computerChoice?.rawValue ?? "")")
                print("user \(userChoice.rawValue)")
                print("Game state: \(gameState?.rawValue ?? "empty")")
                
            }
        }
    }
    var player: AVAudioPlayer?

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
