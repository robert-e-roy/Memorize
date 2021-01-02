//
//  Cardify.swift
//  Memorize
//
//  Created by Robert Roy on 12/30/20.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body (content: Content ) -> some View {
        ZStack {
        if isFaceUp {
            RoundedRectangle(cornerRadius: cornerRadious).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadious).stroke(lineWidth: edgeLineWidth)
            content
            } else {
                RoundedRectangle(cornerRadius: cornerRadious).fill()
            }
        }
    }
    
    private let cornerRadious: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}
   

extension View {
    func cardify(isFaceUp:Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
