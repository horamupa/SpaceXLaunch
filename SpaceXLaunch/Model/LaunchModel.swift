// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dalliE = try? newJSONDecoder().decode(DalliE.self, from: jsonData)

import Foundation

// MARK: - DalliEElement
struct LaunchModel: Codable, Identifiable {
    
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let rocket: Rocket
    let success: Bool?
    let name, dateUTC: String
    let dateUnix: Int
    let datePrecision: DatePrecision
    let upcoming: Bool
    let id: String

    enum CodingKeys: String, CodingKey {
       
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case rocket, success
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case datePrecision = "date_precision"
        case upcoming
        case id
    }
}

enum DatePrecision: String, Codable {
    case day = "day"
    case hour = "hour"
    case month = "month"
}

// MARK: - Failure
struct Failure: Codable {
    let time, altitude: Int
    let reason: String
}

// MARK: - Fairings
struct Fairings: Codable {
    let reused, recoveryAttempt, recovered: Bool?
    let ships: [String]?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered, ships
    }
}

enum Launchpad: String, Codable {
    case the5E9E4501F509094Ba4566F84 = "5e9e4501f509094ba4566f84"
    case the5E9E4502F509092B78566F87 = "5e9e4502f509092b78566f87"
    case the5E9E4502F509094188566F88 = "5e9e4502f509094188566f88"
    case the5E9E4502F5090995De566F86 = "5e9e4502f5090995de566f86"
}

enum Rocket: String, Codable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}
