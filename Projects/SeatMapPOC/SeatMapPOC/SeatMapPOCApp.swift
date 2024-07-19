//
//  SeatMapPOCApp.swift
//  SeatMapPOC
//
//  Created by Rajat Verma on 28/04/23.
//

import SwiftUI

@main
struct SeatMapPOCApp: App {
    private let seats = SeatMapViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(seats: seats)
        }
    }
}
