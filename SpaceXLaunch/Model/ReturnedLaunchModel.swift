//
//  POSModel.swift
//  SpaceXLaunch
//
//  Created by MM on 08.11.2022.
//

import SwiftUI
import Combine

// MARK: - LaunchSpaceX
struct ReturnedLaunchModel: Codable {
    let docs: [Doc]
    let totalDocs, offset, limit, totalPages: Int?
    let page, pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage: Int?
    let nextPage: Int?
}

// MARK: - Doc
struct Doc: Codable, Hashable, Identifiable {
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let rocket: String
    let success: Bool
    let launchpad: String
    let flightNumber: Int
    let name, dateUTC: String
    let dateLocal: String?
    let datePrecision: String?
    let upcoming: Bool
    let id: String
    let dateUnix: Int

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
        case dateUnix = "date_unix"
    }
}

