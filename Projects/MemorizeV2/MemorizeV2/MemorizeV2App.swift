//
//  MemorizeV2App.swift
//  MemorizeV2
//
//  Created by Rajat Verma on 26/04/23.
//

import SwiftUI

@main
struct MemorizeV2App: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
