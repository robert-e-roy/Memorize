//
//  Cardify.swift
//  Memorize
//
//  Created by Robert Roy on 12/30/20.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }

    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body (content: Content ) -> some View {
        ZStack {
        Group{
            RoundedRectangle(cornerRadius: cornerRadious).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadious).stroke(lineWidth: edgeLineWidth)
            content
            }
                .opacity(isFaceUp ? 1 : 0 )
            //RoundedRectangle(cornerRadius: cornerRadious).fill()
            Image("cardBack").resizable()

                .opacity(isFaceUp ? 0 : 1  )

            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))

    }
    
    private let cornerRadious: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}
   

extension View {
    func cardify(isFaceUp:Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
