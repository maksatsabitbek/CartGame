//
//  GameViewController.swift
//  Game2
//
//  Created by Rustem Orazbek on 24.02.2021.
//

import UIKit

class GameViewController: UIViewController {
    lazy var game = GameLogic(numOfPairs: (buttonCollect.count + 1) / 2)
    @IBOutlet var buttonCollect: [UIButton]!
    var touches = 0
    var emojicollection = ["🦊","🐶","🐻","🐯", "🐵", "🐼", "🐱"]
    var emojiDictionary = [Int:String]()
    
    func updateUI(){
        for index in buttonCollect.indices{
        let button = buttonCollect[index]
            let card = game.cards[index]
            if card.isFaceUP{
                button.setTitle(emojiIdentification(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
            else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    func emojiIdentification(for card: Card) -> String{
        if emojiDictionary[card.identifier] == nil{
            let randomIndex = Int(arc4random_uniform(UInt32(emojicollection.count)))
            emojiDictionary[card.identifier] = emojicollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonIndex = buttonCollect.firstIndex(of: sender){
            game.chooseCard(at: buttonIndex)
            updateUI()
            
    }
        if game.matches == (buttonCollect.count/2) {
            let alert = UIAlertController(title: "Finish", message: "Well done, you have matched all pairs!", preferredStyle: .alert)
            let backAction = UIAlertAction(title: "Back to Main Menu", style: .default, handler:    {action in
                self.navigationController?.popViewController(animated: true)
                
            })
            alert.addAction(backAction)
            self.present(alert,animated: true)
            
        }
    }
    
   

}
