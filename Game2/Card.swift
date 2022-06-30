//
//  Card.swift
//  Game2
//
//  Created by DoSSi4 on 24.02.2021.
//

import Foundation

struct Card {
    var isFaceUP = false
    var isMatched = false
    var identifier: Int
    static var identifierNumber = 0
    static func identifierGen() -> Int{
        identifierNumber+=1
        
        return identifierNumber
    }
    init() {
        self.identifier = Card.identifierGen()
    }
}
