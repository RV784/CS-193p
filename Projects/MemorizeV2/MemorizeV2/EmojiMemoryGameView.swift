//
//  EmojiMemoryGameView.swift
//  MemorizeV2
//
//  Created by Rajat Verma on 26/04/23.
//

//Stacks are basically View/Leggo combiners -> view combiners

import SwiftUI

struct EmojiMemoryGameView: View { 
    
    //@ObservedObject the body UI is built again when @ObservedObject var changes.
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        //        ScrollView {
        //            //LazyVGrid specifies number of columns and makes rows accordingly. VicaVerca for LazyHgrid
        //            //It is Lazy of accessing its View's Body in the grid that are not appearing on the screen
        //            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
        //                ForEach(game.cards) { card in
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            CardView(card: card)
                .padding(5)
                .onTapGesture {
                    game.choose(card)
                }
        })
        
        //                }
        //            }.padding()
        //        }//.edgesIgnoringSafeArea([.top])
        //    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}

//LEGO Block
struct CardView: View {
    let card: EmojiMemoryGame.Card //MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let roundRectShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    roundRectShape.fill().foregroundColor(Color(UIColor.systemGray3))
                    roundRectShape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.brown)
                    //Using normal .Stroke draws the border over the view's size. strokeBorder
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    roundRectShape.opacity(0)
                } else {
                    roundRectShape.fill().foregroundColor(.orange)
                    roundRectShape.strokeBorder(lineWidth: 3).foregroundColor(.brown)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height)*DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}




//VIEWS
/*
 **For every struct to be a View, add a Body var of type Some View.
 **the type of "var body: Some View" is replaced with the final type of view that is formed in some View {  } closure func
 
 Our Views are read only. Try to only have let or computed properties in them. Except the @State and @ObservedObject (Property wrappers) variables
 which have to be var instead of let.
 
 Why?
Because of Views are supposed to be stateless. So no need for them to be non-read-only
 
 Make all the @State private
*/




//Stacks
/*
 Stacks divide up the space that is offered to them among in subViews
 It offers space to its "Least flexible" subview first
 
 Eg, ImageView is kind of inflexible. It wants to be a fixed size. Similarly Text is also inflexible
 RoundedRectangle is flexible, always uses zny space that is offered to it.
 Spacer() is a very flexible View
 Divider() is very flexible
 
 Stack does the above procedure from least flexible to most flexible
 very flexible views take even spaces
 
 
 You can override this property of stack with .layoutPriority(Double)
 
 HStack {
    Text ("Important"). layoutPriority(100) // any floating point number is okay
    Image(systemName: "arrow. up") // the default layout priority is 0
    Text ("Unimportant")
 }
 Here the Text first is going to get space assigned and then the image will be given space...
 
 ZStacks
 - Sizes itself to fit its children
 - If even one of its children is fully flexible size, then the ZStack will be too
 
 Alternatives to ZStack
 - .background(some view) -> Text("hello").background(Rectangle().foregroundColor(.red))
 Here the text will define the size for the bgView.
 
 - .overlay(some View) -> Opposite of .background
*/



//LazyHStacks LazyVStack
/*
The lazy verison of stack don't build up bodies of Views that are not on screen.
Use it when Stack is inside scrollView
*/


//Identifiable Protocol
/*
 - It has a don't care.
 protocol Identifiable {
    var id: ID { get } //ID is don't care. The type ID is hashable
 }
*/


//Hashable Protocol
/*
 Hashable is a simple protocol.
 
 protocol Hashable {
    func hash(into hasher: inout Hasher) // a Hasher just has a combine(.) func on it
 }
 
 Here's a struct that implements Hashable.
 Don't worry about the inout keyword for now (you'll read about it in your reading assignments).
 
struct Foo: Hashable {
    var i: Int var s: String
    var s: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(i)
        hasher.combine(s)
    }
 
 Hashable protocol inherits Equatable protocol. Because when you hash something and use the hash to look it up
 in a hash table, you've to be able to use == on the thing to make sure it is the same thing you hashed because it
 is possible for two different things to hash to the same value
*/


//Equatable
/*
 
 protocol Equatable {
    static func ==(lhs: self, rhs: self) -> Bool
 }
 
 
 
*/
