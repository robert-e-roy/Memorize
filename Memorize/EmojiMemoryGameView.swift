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
        VStack {
        Text("Theme name and score \(viewModel.score)")
        Grid( viewModel.cards)  {  card in // view builder
            CardView(card: card).onTapGesture {
                withAnimation(.linear(duration: 0.75))  {
                viewModel.choose(card: card)
                }
            }
            .padding(5)

        }
    .font(viewModel.cards.count / 2 > 4 ? .callout : .largeTitle)
            .padding()
            .foregroundColor(Color.orange)
            Button(  action: {
                withAnimation(.easeInOut) {
                        viewModel.newGame()
                }
            }, label: { Text ("New Game") })
        }
    }

}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader  { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    
    @ViewBuilder
    private func body (for size: CGSize ) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90),clockwise: true)
                            .onAppear {
                            startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-card.bonusRemaining*360-90),clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size:fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0 ))
                    .animation(card.isMatched ? Animation.linear.repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    //MARK: - Drawing Constants


    private let fontScaleFacter: CGFloat = 0.7
    // tiny function to make it look nicer
    
    func fontSize (for size: CGSize) -> CGFloat {
        min (size.width,size.height) * fontScaleFacter
}

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            let game = EmojiMemoryGame()
            game.choose(card: game.cards[0])
        return Group {
            EmojiMemoryGameView(viewModel: game)
                .environment(\.sizeCategory, .extraLarge)
        
        }
    }
}
