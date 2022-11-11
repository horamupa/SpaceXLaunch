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
    let succes: Bool?
    let date_local: String?
    let id: String?
    let upcoming: Bool?
    
//    POSModel(rocket: "5e9d0d96eda699382d09d1ee", upcoming: false)
    static let share = POSModel(rocket: "5e9d0d96eda699382d09d1ee", succes: nil, date_local: nil, id: nil, upcoming: false)
    
    init(rocket: String, succes: Bool?, date_local: String?, id: String?, upcoming: Bool) {
        self.rocket = rocket
        self.succes = succes
        self.date_local = date_local
        self.id = id
        self.upcoming = upcoming
    }
    
    enum CodingKeys: CodingKey {
        case rocket
        case succes
        case date_local
        case id
        case upcoming
    }
}


// MARK: - LaunchSpaceX
struct returnModel: Codable {
    let docs: [Doc]
    let totalDocs, offset, limit, totalPages: Int
    let page, pagingCounter: Int
    let hasPrevPage, hasNextPage: Bool
    let prevPage: Int
    let nextPage: Int
}

// MARK: - Doc
struct Doc: Codable {
    let staticFireDateUTC: String
    let staticFireDateUnix: Int
    let rocket: String
    let success: Bool
    let launchpad: String
    let flightNumber: Int
    let name, dateUTC: String
    let dateLocal: String
    let datePrecision: String
    let upcoming: Bool
    let id: String

    enum CodingKeys: String, CodingKey {
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case rocket, success, launchpad
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming, id
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
