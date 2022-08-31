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
    @Published var isMetricHeight: Bool = true
    @Published var isMetricDiametr: Bool = true
    @Published var isMetricMass: Bool = true
    @Published var isMetricUsefulWeight: Bool = true
    @Published var roket1 = RoketModel.share
    @Published var isPreference: Bool = false
    @Published var preferenceArray: [Bool] = [true,true,true,true]
    
    static var rroket = RoketModel.share
    
//    static let rroket = RoketModel(name: "name", active: false, stages: 3, boosters: 2, costPerLaunch: 23, successRatePct: 43, firstFlight: "Tommorow", country: "USA", company: "SpaceX", wikipedia: "gogo", spaceXDescription: "gogo", id: "123", mass: Mass(kg: 3, lb: 3), height: Diameter(meters: 3, feet: 3), diameter: Diameter(meters: 3, feet: 3), firstStage: FirstStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), secondStage: SecondStage(engines: 3, fuelAmountTons: 3, burnTimeSEC: 3), payloadWeights: [PayloadWeight(id: "3", name: "3", kg: 3, lb: 3)], flickrImages: ["",""])
    
    
    func fetch() {
        guard let url = URL(string: RoketModel.url) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                let fetInfo = try decoder.decode([RoketModel].self, from: data)
                DispatchQueue.main.async {
                    self!.roketArray = fetInfo
                    self!.isFetched = true
                    self!.roket1 = self!.roketArray[0]
                    
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        print(roketArray.count)
    }
    
    func savePreference() {
        let settings = self.preferenceArray
        guard let encoder = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(encoder, forKey: "save_it")
    }
    
    func setPreference() {
        guard let data = UserDefaults.standard.data(forKey: "save_it"),
              let decodedData = try? JSONDecoder().decode([Bool].self, from: data)
        else { return }
        self.preferenceArray = decodedData
    }
    
    
    
    init() {
        preferenceArray = [isMetricHeight, isMetricDiametr, isMetricMass, isMetricUsefulWeight]
        fetch()
        setPreference()
    }
    
//    init() { }
    
}
