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
        
        let themes: [([String], UIColor, String, Int)] = [(["😀", "😃", "😄","😂","😍", "🥰","😛","😇"], UIColor.yellow, "Faces", Int.random(in: 3..<8)),
                      (["👊","✊","🤛","🤜","🤞","🤟","👐","🤝","💪"], UIColor.yellow, "Hands", Int.random(in: 3..<8)),
                      (["🐶", "🐱","🐭","🐹","🐰","🐯","🐮","🐵","🐷","🦊","🐼"], UIColor.systemPink, "Animals", 4),
                      (["☀️","🌤","🌧","🌩","❄️","☔️","🌥","☁️","🌦"], UIColor.blue, "Weather", 4),
                      (["🍐","🥝","🥗","🥒","🍏","🍉","🥦","🥑","🥬"], UIColor.green,"Greens", Int.random(in: 3..<9))
        ]
        var selectedTheme = themes[Int.random(in: 0..<themes.count)]
        selectedTheme.0.shuffle()
        
        return  MemoryGame<String>(numberofPairsOfCards: selectedTheme.3, themeAttributes: selectedTheme) {pairIndex in
            
            return selectedTheme.0[pairIndex]
        }
    }
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var theme: MemoryGame<String>.Theme {
        return model.theme
    }
    
    var points: Int {
        return model.points
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
