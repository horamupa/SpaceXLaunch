//
//  LaunchModel.swift
//  SpaceXLaunch
//
//  Created by MM on 02.11.2022.
//

import SwiftUI

// MARK: - LocationJSONElement
struct LaunchModel: Codable, Hashable, Identifiable {
    let rocket: Rocket
    let success: Bool?
    let name, id, dateUTC: String

    enum CodingKeys: String, CodingKey {

        case rocket, success
        case name
        case dateUTC = "date_utc"
        case id
    }
}


enum Rocket: String, Codable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}




