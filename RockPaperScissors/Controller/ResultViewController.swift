//
//  ResultViewController.swift
//  RockPaperScissors
//
//  Created by Kader Oral on 7.07.2023.
//

import UIKit
protocol ResultViewControllerDelegate: AnyObject {
    func resetScores()
}

class ResultViewController: UIViewController {
    @IBOutlet weak var gameStateLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var computerImageView: UIImageView!
    
    weak var delegate: ResultViewControllerDelegate?
    var userChoice: Guess?
    var computerChoice: Guess?
    var gameState: GameState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStateLabel.text = gameState?.rawValue ?? "fdrgfd"
        userImageView.image = UIImage(named: String(userChoice?.rawValue.lowercased() ?? "rock"))
        computerImageView.image = UIImage(named: String(computerChoice?.rawValue.lowercased() ?? "rock"))
        
    }
    
    @IBAction func resetAndPlayButtonTap(_ sender: UIButton) {
        delegate?.resetScores()
        navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func keepPlayButtonTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
