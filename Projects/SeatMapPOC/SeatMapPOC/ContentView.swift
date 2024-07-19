//
//  ContentView.swift
//  SeatMapPOC
//
//  Created by Rajat Verma on 28/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var seats: SeatMapViewModel
    
    var gridItems: [GridItem] = [
        .init(),
        .init(),
        .init(),
        .init(),
        .init(),
        .init(),
        .init()
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(seats.model.seats, id: \.self) { row in
                    ForEach(row, id: \.self) { seat in
                        SeatBox(seatData: seat)
                            .aspectRatio(1/1, contentMode: .fill)
                            .onTapGesture {
                                if !seat.isEmpty && !seat.isBooked {
                                    seats.chooseSeat(seat)
                                }
                            }
                    }
                }
            }.padding(.horizontal, 30)
        }.scrollIndicators(.hidden)
    }
}

struct SeatBox: View {
    
    let seatData: SeatMapModel.Seat
    
    var body: some View {
        ZStack {
            let roundRectangle = RoundedRectangle(cornerRadius: 5)
            if seatData.isEmpty {
                Spacer()
            } else if seatData.isBooked {
                roundRectangle.fill().foregroundColor(Color(UIColor.gray))
                roundRectangle.strokeBorder(lineWidth: 2).foregroundColor(.brown)
                Text(seatData.name)
            } else if seatData.isSelected {
                roundRectangle.fill().foregroundColor(Color(UIColor.systemGreen))
                roundRectangle.strokeBorder(lineWidth: 2).foregroundColor(.gray)
                Text(seatData.name)
            } else {
                roundRectangle.fill().foregroundColor(Color(UIColor.systemGray6))
                roundRectangle.strokeBorder(lineWidth: 2).foregroundColor(.gray)
                Text(seatData.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let seats = SeatMapViewModel()
        ContentView(seats: seats)
    }
}
