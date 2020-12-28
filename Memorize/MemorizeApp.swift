//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Robert Roy on 12/26/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        let game = EmojiMemoryGame()
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
