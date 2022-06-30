//
//  GameLogic.swift
//  Game2
//
//  Created by DoSSi4 on 24.02.2021.
//

import Foundation


class GameLogic{
    var cards = [Card]()
    var FaceCard: Int?
    var matches = 0
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = FaceCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matches+=1
                }
                cards[index].isFaceUP = true
                FaceCard = nil
                }
            else{
                for flipDown in cards.indices{
                    cards[flipDown].isFaceUP = false
                }
                cards[index].isFaceUP = true
                FaceCard = index
            }
            
        }
        
    }
    init(numOfPairs: Int){
        for _ in 1...numOfPairs{
            let card = Card()
            cards += [card,card]
        }
    
    var lastCardIndex = cards.count - 1;
           
           while lastCardIndex > 0 {
               let randomIndex = Int(arc4random_uniform(UInt32(lastCardIndex)))
               cards.swapAt(randomIndex, lastCardIndex)
               lastCardIndex -= 1
           }
    }
}
