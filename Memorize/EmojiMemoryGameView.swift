//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Robert Roy on 12/26/20.
//
// view 2 views , one is a card one is the group

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel:EmojiMemoryGame
    
    var body: some View {
        Grid( viewModel.cards)  {  card in // view builder
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
    .font(viewModel.cards.count / 2 > 4 ? .callout : .largeTitle)
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader  { geometry in
            self.body(for: geometry.size)
        }
    }
            
    private func body (for size: CGSize ) -> some View {
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadious).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadious).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadious).fill()
                    }
                }
            }
            .font(Font.system(size: fontSize(for: size)))
       }
    //MARK: - Drawing Constants

    private let cornerRadious: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFacter: CGFloat = 0.75
    // tiny function to make it look nicer
    
    func fontSize (for size: CGSize) -> CGFloat {
        min (size.width,size.height) * fontScaleFacter
}

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
