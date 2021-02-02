//
//  MemoryGame.swift
//  Memorize
//
//  Created by Robert Roy on 12/27/20.
//
// this is the MODEL
//MARK: - MODEL
//  Rob was here
// git

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    // need mutating in a struct
    
    var score = 0
    var themeNamed = ""
    
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
                self.cards[chosenIndex].countNumberOfView += 1


            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
   
    
    init(numberOfPairsOfCards: Int, themeName: String,cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        themeNamed = themeName
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))

        }
        cards.shuffle()
        
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var countNumberOfView: Int = 0
        var content: CardContent
        var id: Int
    
        

    
        
        
 

    //MARK: - Bonus Time

    // this could give matching bousn points




        var bonusTimeLimit: TimeInterval = 6
      
        // how long this card has been face up
         var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up ( and is still face up)
        var lastFaceUpDate: Date?
        // the accumlated time this card has bee face up in the past
        // ( i.e. not including the current time it's been face up if ist is currently so )
        var pastFaceUpTime: TimeInterval = 0

        // how much time left before the bonus oppertunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0,bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaingn
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0 ) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        // whether we are currently face up, unmattched and have not yet used up the bonus window
        var hasEarnedBonus: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        // wheather we are currently face up, unmatch and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        // called when the card transision to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card gos back face down ( or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
