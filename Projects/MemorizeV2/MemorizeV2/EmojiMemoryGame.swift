//
//  EmojiMemoryGame.swift
//  MemorizeV2
//
//  Created by Rajat Verma on 26/04/23.
//

//The ViewModel part of MVVM. It can import swift UI
//Mediatary between Model and View
import SwiftUI

//ObservableObject -> Gives the ability to shout to the world that something changed
class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    //Static means it is global, but its name is now EmojiMemoryGame.emojis
    private static let emojis = ["😄", "🥲", "❤️", "🦈", "🤑", "🤒", "🫥", "🍰", "🍚", "🐶", "⚾️", "🇮🇳", "🐹", "💀", "🥽", "🥊", "🌝", "👍🏻", "🛑", "✅", "💯", "🎈", "😯"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        .init(numberOfPairsOfCards: 10) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    
    //MARK: Intent Functions
    ///Shows user intent to ViewModel layer
    func choose(_ card: Card) {
        //Either add objectWillChange.send() to publish changes OR, add @Published before the model/array that is supposed to change
        //objectWillChange.send()
        model.choose(card)
    }
}

//Swift is able to detect changes in a struct. cannot do it in a class

///ViewModels is supposed to be observable object
///ObservableObjects get an objectWillChange object, using this variable we announce to the world that something has changed
 
