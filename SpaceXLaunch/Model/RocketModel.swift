

import Foundation
import SwiftUI



struct RocketModel: Codable, Identifiable, Hashable {
    let name: String
    let costPerLaunch: Double
    let firstFlight, country, company: String
    let id: String
    let mass: Mass
    let height, diameter: Diameter
    let firstStage: FirstStage
    let secondStage: SecondStage
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    
    static var share = RocketModel(id: "123", images: ["https://i.imgur.com/DaCfMsj.jpg", "https://hws.dev/img/logo.png"], name: "SpaceX1", firstStage: FirstStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), height: Diameter(meters: 3, feet: 3), diameter: Diameter(meters: 3, feet: 3), mass: Mass(kg: 3, lb: 3), payloadWeights: [PayloadWeight(id: "2", name: "2", kg: 23, lb: 23)], firstFlight: "go", country: "go", company: "go", costPerLaunch: 13, secondStage: SecondStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3))
    
    static let url = "https://api.spacexdata.com/v4/rockets"
    

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country, company
        case id
    }
    
    init(id: String = "Rocket", images: [String] = [""], name: String = "Roket", firstStage: FirstStage = FirstStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), height: Diameter, diameter: Diameter, mass: Mass, payloadWeights: [PayloadWeight], firstFlight: String, country: String, company: String, costPerLaunch: Double, secondStage: SecondStage) {
        self.id = id
        self.flickrImages = images
        self.name = name
        self.firstStage = firstStage
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.payloadWeights = payloadWeights
        self.firstFlight = firstFlight
        self.country = country
        self.company = company
        self.costPerLaunch = costPerLaunch
        self.secondStage = secondStage
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.firstFlight = try container.decode(String.self, forKey: .firstFlight)
            self.country = try container.decode(String.self, forKey: .country)
            self.company = try container.decode(String.self, forKey: .company)
            self.firstStage = try container.decode(FirstStage.self, forKey: .firstStage)
            self.flickrImages = try container.decode([String].self, forKey: .flickrImages)
            self.mass = try container.decode(Mass.self, forKey: .mass)
            self.height = try container.decode(Diameter.self, forKey: .height)
            self.diameter = try container.decode(Diameter.self, forKey: .diameter)
            self.payloadWeights = try container.decode([PayloadWeight].self, forKey: .payloadWeights)
            self.secondStage = try container.decode(SecondStage.self, forKey: .secondStage)
            self.costPerLaunch = try container.decode(Double.self, forKey: .costPerLaunch)

        }
    
    
}

//// MARK: - Diameter
struct Diameter: Codable, Hashable {
    let meters, feet: Double
}

// MARK: - Engines
struct Engines: Codable, Hashable {
    let isp: ISP
    let thrustSeaLevel, thrustVacuum: Thrust
    let number: Int
    let type, version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1, propellant2: String
    let thrustToWeight: Double

    enum CodingKeys: String, CodingKey {
        case isp
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case number, type, version, layout
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}

// MARK: - ISP
struct ISP: Codable, Hashable {
    let seaLevel, vacuum: Int

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum
    }
}

// MARK: - Thrust
struct Thrust: Codable, Hashable {
    let kN, lbf: Int
}

// MARK: - FirstStage
struct FirstStage: Codable, Hashable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - LandingLegs
struct LandingLegs: Codable, Hashable {
    let number: Int
    let material: String?
}

// MARK: - Mass
struct Mass: Codable, Hashable {
    let kg, lb: Double
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable, Hashable {
    let id, name: String
    let kg, lb: Double
}

// MARK: - SecondStage
struct SecondStage: Codable, Hashable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - Payloads
struct Payloads: Codable, Hashable {
    let compositeFairing: CompositeFairing
    let option1: String

    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option1 = "option_1"
    }
}

// MARK: - CompositeFairing
struct CompositeFairing: Codable, Hashable {
    let height, diameter: Diameter
}

typealias SpaceX = [RocketModel]
