//
//  RoketViewModelApi2.swift
//  SpaceXLaunch
//
//  Created by MM on 17.08.2022.
//

import Foundation

class RocketViewModel: ObservableObject {
    
//    @Published var shared = RoketViewModel()
    
    @Published var isFetched: Bool = false
    @Published var roketArray = [rroket]
    @Published var launchArray: [LaunchModel] = []
    @Published var isMetricHeight: Bool = true
    @Published var isMetricDiametr: Bool = true
    @Published var isMetricMass: Bool = true
    @Published var isMetricUsefulWeight: Bool = true
    @Published var roket1 = RocketModel.share
    @Published var isPreference: Bool = false
    @Published var preferenceArray: [Bool] = [true,true,true,true]
    
    static var rroket = RocketModel.share 
    private var manager = DataManager()
    
    
    func fetchJSON() async {
        do {
            if let decodedJSON = try await manager.fetchJSON() {
                await MainActor.run(body: {
                    self.roketArray = decodedJSON
                    print("rocket array OK")
                })
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchJSON2() async {
        do {
           if let launchJSON = try await manager.fetchJSON2() {
                await MainActor.run(body: {
                    self.launchArray = launchJSON
                    print("launch array OK")
                })
            }
        } catch {
            print(error.localizedDescription)
        }
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
        setPreference()
    }
}
