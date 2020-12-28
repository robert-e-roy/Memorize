//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Robert Roy on 12/27/20.
// View Model Shared by many views 


import SwiftUI

// @Published property any change objectwillchange.send()

class EmojiMemoryGame: ObservableObject {
    @Published private var model:  MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame () -> MemoryGame<String>{
        let emojis  = ["👻","🎃","🕷","💀","🧙"]
        
        return MemoryGame<String>(numberOfPairsOfCards:Int.random(in: 2...5) ) { pariIndex in
            return emojis[pariIndex]
        }
    }

    //MARK: - Access to Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card:card)
    }
}
