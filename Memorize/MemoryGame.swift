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
    var cards: Array<Card>
    // need mutating in a struct
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }

        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true

                } else {
                    cards[index].isFaceUp = false

                }
                
            }
        }
    }
    
    
    mutating func choose(card:Card ){
        if let chosenIndex = cards.firstIndex(matching: card) , !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {  // sequntial and &&
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
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
