//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Derek Chang on 8/15/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation


class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        var emojis: Array<String> = ["🕺", "⛹️‍♀️", "🏄‍♂️", "🏆","🎬", "🥂", "🍿", "⚽️", "🧃", "🍏", "🍓", "🍊", "🍉", "🍍"]
        emojis.shuffle()
        let randomNumOfCards = Int.random(in: 5...7)
        return  MemoryGame<String>(numberofPairsOfCards: randomNumOfCards) {pairIndex in
            return emojis[pairIndex]
        }
    }
    
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}
