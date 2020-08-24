//
//  EmojiMemoryGameView.swift
//  memorize
//
//  Created by Derek Chang on 8/14/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    //everytime this property receives objectwillchange, it redraws the view (reactive programming)
    @ObservedObject var viewModel: EmojiMemoryGame
    		
    var body: some View {
        
        VStack {
            HStack{
                Text(String(describing: self.viewModel.theme.title))
                    .font(.title)
                
            }
            
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
            }
            .foregroundColor(.orange)
            .padding()
        }
        
    }
}
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    //computed property
    var body: some View {
        
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched { //if card isMatched, don't draw it anymore
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let lineWidth: CGFloat = 3.0
    
     func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
