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
            HStack(alignment: .bottom){
                
                Text(String(describing: self.viewModel.theme.title))
                    
                    .font(.largeTitle)
                    .layoutPriority(2)
                Spacer()
                
                Text(String(describing: self.viewModel.points))
                    .layoutPriority(1)
                    .font(Font.custom("San Francisco", size: 35))
                    .foregroundColor(Color.black)
                
                    
                Spacer()
                
                Button(action: {
                    print("New Game Button Pressed")
                    self.viewModel.resetGame()
                }) {
                    Text("New Game")
                        .font(.headline)
                }
                .padding(.all, 12)
                .foregroundColor(.white)
                    
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.blue))
                .layoutPriority(1)
                
                
                
            }
            .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
            .padding(EdgeInsets.init(top: 4, leading: 16, bottom: 4, trailing: 16))
            
            ZStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card, themeColor: self.viewModel.theme.color).onTapGesture {
                            self.viewModel.choose(card: card)
                        }
                        .padding(5)
                        
                }
                .foregroundColor(self.viewModel.theme.color)
                .padding()
                
                
            }
            
        }
        
    }
}
struct CardView: View {
    var card: MemoryGame<String>.Card
    var themeColor: Color
    
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
                if !card.isMatched { //only draw if not face up and not Matched
                    RoundedRectangle(cornerRadius: cornerRadius)
                        
                        .fill(LinearGradient(gradient: Gradient(colors: [.white, themeColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .border(Color.black, width: 1)
                        .shadow(radius: 2)
                    
                    
                    
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
