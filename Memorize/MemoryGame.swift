//
//  MemoryGame.swift
//  Memorize
//
//  Created by Robert Roy on 12/27/20.
//
// this is the MODEL
//MARK: - MODEL

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    // need mutating in a struct
    
    var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter {  cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    
    mutating func choose(card:Card ){
        if let chosenIndex = cards.firstIndex(matching: card) , !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {  // sequntial and &&
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 // found a match

                }
                self.cards[chosenIndex].isFaceUp = true

            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
   
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))

        }
        cards.shuffle()
        
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
