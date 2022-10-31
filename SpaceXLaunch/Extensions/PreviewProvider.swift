//
//  PreviewProvider.swift
//  SpaceXLaunch
//
//  Created by MM on 31.10.2022.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() {  }
    
    let homeVM = RocketViewModel()
    
    let roket = RocketModel(id: "123", images: ["https://hws.dev/img/logo.png", "https://hws.dev/img/logo.png"], name: "gogoroket", firstStage: FirstStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), height: Diameter(meters: 3, feet: 3), diameter: Diameter(meters: 3, feet: 3), mass: Mass(kg: 3, lb: 3), payloadWeights: [PayloadWeight(id: "2", name: "2", kg: 23, lb: 23)], firstFlight: "go", country: "go", company: "go", costPerLaunch: 13, secondStage: SecondStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3))
}
