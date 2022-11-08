//
//  POSModel.swift
//  SpaceXLaunch
//
//  Created by MM on 08.11.2022.
//

import SwiftUI
import Combine

struct POSModel: Codable, Identifiable {
    let rocket: String
    let succes: Bool
    let date_local: String
    let id: String
    
    static let share = POSModel(rocket: "5e9d0d95eda69973a809d1ec", succes: true, date_local: "2020-03-06T23:50:31-05:00", id: "123")
    
    init(rocket: String, succes: Bool, date_local: String, id: String) {
        self.rocket = rocket
        self.succes = succes
        self.date_local = date_local
        self.id = id
    }
    
    enum CodingKeys: CodingKey {
        case rocket
        case succes
        case date_local
        case id
    }
}

