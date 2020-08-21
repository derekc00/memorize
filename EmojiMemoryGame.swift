//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Derek Chang on 8/15/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation
import UIKit

class EmojiMemoryGame: ObservableObject {
    
    
    //portal to the model. It should talk to the model all it wants.
    //@Published is important!! property wrapper tells views looking at this viewmodel that the model will change so it needs to redraw
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        let themes = [theme(emojiSet: ["😀", "😃", "😄","😂","😍", "🥰","😛","😇"], color: UIColor.yellow, title: "Faces"),
                      theme(emojiSet: ["👊","✊","🤛","🤜","🤞","🤟","👐","🤝","💪"], color: UIColor.yellow, title: "Hands"),
                      theme(emojiSet: ["🐶", "🐱","🐭","🐹","🐰","🐯","🐮","🐵","🐷","🦊","🐼"], color: UIColor.systemPink, title: "Animals"),
                      theme(emojiSet: ["☀️","🌤","🌧","🌩","❄️","☔️","🌥","☁️","🌦"], color: UIColor.blue, title: "Weather"),
                      theme(emojiSet: ["🍐","🥝","🥗","🥒","🍏","🍉","🥦","🥑","🥬"], color: UIColor.green, title: "Greens")
        ]
        var currentTheme = themes[Int.random(in: 0..<themes.count)]
        currentTheme.shuffleEmojis()
        
        return  MemoryGame<String>(numberofPairsOfCards: currentTheme.numberOfCardsShown) {pairIndex in
            return currentTheme.emojiSet![pairIndex]
        }
    }
    
    struct theme{
        var emojiSet: [String]?
        var color: UIColor?
        var numberOfCardsShown: Int = 0
        var title: String?
        
        init(emojiSet: [String], color: UIColor, title: String) {
            self.emojiSet = emojiSet
            self.color = color
            self.title = title
            
            self.numberOfCardsShown = self.title == "Faces" ? 3 : Int.random(in: 4...7)
        }
        
        mutating func shuffleEmojis(){
            guard (emojiSet != nil) else{
                print("cannot shuffle nil emoji set")
                return
            }
            self.emojiSet?.shuffle()
        }
    }
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
