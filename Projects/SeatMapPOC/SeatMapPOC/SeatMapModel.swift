//
//  SeatMapModel.swift
//  SeatMapPOC
//
//  Created by Rajat Verma on 28/04/23.
//

import Foundation

struct SeatMapModel {
    private(set) var seats: [[Seat]]
    
    init(seats: [[Seat]]) {
        self.seats = seats
    }
    
    mutating func chooseSeat(_ seat: Seat) {
        seats[seat.seatRow][seat.seatCol].isSelected.toggle()
    }
    
    
    struct Seat: Hashable {
        var isEmpty: Bool
        var isAisle: Bool
        var isSelected: Bool
        var isBooked: Bool
        var seatRow: Int
        var seatCol: Int
        var id: Int
        var name: String
    }
    
    struct SeatRow_R: Codable {
        var seats: [SeatData_R]?
    }
    
    struct SeatData_R: Codable {
        var code: String?
        var seatNo: String?
        var dsc: String?
        var isBooked: Bool?
        var isAisle: Bool?
        var isWindow: Bool?
        var amt: Int?
        var priceBracket: Int?
    }
}
