//
//  MemoryGame.swift
//  MemorizeV2
//
//  Created by Rajat Verma on 26/04/23.
//

//The Model part of MVVM. Does not need SwiftUI
import Foundation

//The where CardContent: Equatable makes the don't care type CardContent Equatab le
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp })
            return faceUpCardIndices.oneAndOnly //count == 1 ? faceUpCardIndices[0] : nil
        }
        set {
            cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue)})
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIdx = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIdx].isFaceUp,
           !cards[chosenIdx].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIdx].content == cards[potentialMatchIndex].content {
                    cards[chosenIdx].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIdx].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIdx
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        //add numberOfPairsOfCards*2 number of cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(.init(content: content, id: pairIndex*2))
            cards.append(.init(content: content, id: pairIndex*2 + 1))
        }
    }
    
    //Identifiable:- uses one varaible to differentiate one Card from another Card
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
    
    //CardContent is a don't care type. It can be anything (String, Int, Array etc)
    //
}

extension Array {
    var oneAndOnly: Element? {
        return self.count == 1 ? self.first : nil
    }
}


