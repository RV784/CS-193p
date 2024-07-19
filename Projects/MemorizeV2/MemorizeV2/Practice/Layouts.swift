//
//  Layouts.swift
//  MemorizeV2
//
//  Created by Rajat Verma on 27/04/23.
//

import SwiftUI

struct Layouts: View {
    var body: some View {
        Text("This is a crd").overlay(CardView_new(card: ""))
    }
}


struct CardView_new: View {
    let card: String //MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let roundRectShape = RoundedRectangle(cornerRadius: 15)
            roundRectShape.fill().foregroundColor(Color(UIColor.systemGray3))
            roundRectShape.strokeBorder(lineWidth: 3).foregroundColor(.brown)
            //Using normal .Stroke draws the border over the view's size. strokeBorder
            Text(card).font(.largeTitle).padding()
        }.opacity(0.5)
    }
}

struct Layouts_Previews: PreviewProvider {
    static var previews: some View {
        Layouts()
    }
}
