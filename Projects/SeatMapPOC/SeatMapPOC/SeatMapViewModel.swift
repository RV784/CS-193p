//
//  SeatMapViewModel.swift
//  SeatMapPOC
//
//  Created by Rajat Verma on 28/04/23.
//

import SwiftUI

class SeatMapViewModel: ObservableObject {
    
    @Published var model = createRealSeatData() //createSeatsData()
    
    private static func createRealSeatData() -> SeatMapModel {
        if let bundlePath = Bundle.main.path(forResource: "SeatRealData",
                                             ofType: "json"),
           let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8),
           let result = try? JSONDecoder().decode([SeatMapModel.SeatRow_R].self, from: jsonData) {
            return transformData(data: result)
        }
        
        return .init(seats: [[]])
    }
    
    private static func transformData(data: [SeatMapModel.SeatRow_R]) -> SeatMapModel {
        var maxCol = 0
        for row in data {
            maxCol = max(maxCol, row.seats?.count ?? 0)
        }
        
        var seatsData: [[SeatMapModel.Seat]] = []
        
        for rowIdx in 0..<data.count {
            var seatRow: [SeatMapModel.Seat] = []
            for colIdx in 0..<maxCol {
                if let seat = data[safe: rowIdx]?.seats?[safe: colIdx],
                   seat.seatNo != nil {
                    let seat: SeatMapModel.Seat = .init(
                        isEmpty: false,
                        isAisle: seat.isAisle ?? false,
                        isSelected: false,
                        isBooked: seat.isBooked ?? false,
                        seatRow: rowIdx,
                        seatCol: colIdx,
                        id: rowIdx*7 + colIdx,
                        name: seat.code ?? "")
                    seatRow.append(seat)
                } else {
                    let seat: SeatMapModel.Seat = .init(
                        isEmpty: true,
                        isAisle: false,
                        isSelected: false,
                        isBooked: false,
                        seatRow: rowIdx,
                        seatCol: colIdx,
                        id: rowIdx*7 + colIdx,
                        name: "")
                    seatRow.append(seat)
                }
            }
            seatsData.append(seatRow)
        }
        
        return .init(seats: seatsData)
    }
    
    //MARK: Intent Functions
    func chooseSeat(_ seat: SeatMapModel.Seat) {
        model.chooseSeat(seat)
    }
}



extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
