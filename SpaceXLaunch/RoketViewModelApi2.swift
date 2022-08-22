//
//  RoketViewModelApi2.swift
//  SpaceXLaunch
//
//  Created by MM on 17.08.2022.
//

import Foundation

class RoketViewModel: ObservableObject {
    
//    @Published var shared = RoketViewModel()
    
    @Published var isFetched: Bool = false
    @Published var roketArray = [rroket]
    @Published var isMetric: Bool = true
    @Published var roket1 = RoketModel.share
    
    static var rroket = RoketModel.share
    
//    static let rroket = RoketModel(name: "name", active: false, stages: 3, boosters: 2, costPerLaunch: 23, successRatePct: 43, firstFlight: "Tommorow", country: "USA", company: "SpaceX", wikipedia: "gogo", spaceXDescription: "gogo", id: "123", mass: Mass(kg: 3, lb: 3), height: Diameter(meters: 3, feet: 3), diameter: Diameter(meters: 3, feet: 3), firstStage: FirstStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), secondStage: SecondStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), payloadWeights: [PayloadWeight(id: "3", name: "3", kg: 3, lb: 3)], flickrImages: ["",""])
    
    
    func fetch() {
        guard let url = URL(string: RoketModel.url) else { return }
        print("URL created")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let fetInfo = try decoder.decode([RoketModel].self, from: data)
                print("fetch done")
                DispatchQueue.main.async {
                    self!.roketArray = fetInfo
                    print(self!.roketArray[0].flickrImages[0])
//                    print(self!.roketArray[0].name)
                    self!.isFetched = true
                    self!.roket1 = self!.roketArray[0]
                    print(self!.roket1.name)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        print(roketArray.count)
    }
    init() { }
}
