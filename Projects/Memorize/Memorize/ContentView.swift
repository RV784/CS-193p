//
//  ContentView.swift
//  Memorize
//  Created by Rajat Verma on 25/04/23.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["😄", "🥲", "❤️", "🦈", "🤑", "🤒", "🫥", "🍰", "🍚", "🐶", "⚾️", "🇮🇳", "🐹", "💀", "🥽", "🥊", "🌝", "👍🏻", "🛑", "✅", "💯", "🎈", "😯"]
    @State var emojiCount = 4
    
    var body: some View {
        //Stacks are basically View/Leggo combiners -> view combiners
        VStack {
            HStack {
                //id: is used to uniquely identify elements in the array. If two elements are same, it'll make the same UI for both.
                ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                    CardView(emoji: emoji)
                })
            }.padding()
            HStack {
                removeBtn
                Spacer()
                addBtn
            }.padding(.horizontal)
                .foregroundColor(.blue)
        }.padding()
    }
    
    var removeBtn: some View {
        Button {
            emojiCount = emojiCount > 1 ? emojiCount - 1 : emojiCount
        } label: {
            VStack {
                Text("Remove")
                Text("Card")
            }
        }
    }
    
    var addBtn: some View {
        Button {
            emojiCount = emojiCount < emojis.count ? emojiCount + 1 : emojiCount
        } label: {
            VStack {
                Text("Add")
                Text("Card")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//LEGO Block
struct CardView: View {
    
    //State makes the var a pointer, that points to a var at some other place.
    //When state variable changes, it rebuilds the whole view
    @State var isFaceUp: Bool = false
    
    var emoji: String
    
    var body: some View {
        ZStack {
            let roundRectShape = RoundedRectangle(cornerRadius: 25)
            if isFaceUp {
                roundRectShape.fill().foregroundColor(Color(UIColor.systemGray3))
                roundRectShape.stroke(lineWidth: 5)
                Text(emoji).font(.largeTitle)
            } else {
                roundRectShape.fill().foregroundColor(.orange)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
