//
//  MemoryGame.swift
//  memorize
//
//  Created by Derek Chang on 8/15/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation

//protocol: our generic CardContent only works when it implements Equatable protocol
struct MemoryGame<CardContent> where CardContent : Equatable{
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter {cards[$0].isFaceUp}.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberofPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberofPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
        print(cards.count)
    }
    
    mutating func choose(card: Card) {
        print("card chosen \(card)")
//        choose the correct card, make sure it is NOT face up and NOT matched
        print(cards)
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            print(chosenIndex)
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
