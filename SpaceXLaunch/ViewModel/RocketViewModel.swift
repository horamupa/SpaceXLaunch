//
//  RoketViewModelApi2.swift
//  SpaceXLaunch
//
//  Created by MM on 17.08.2022.
//

import SwiftUI
import Combine

class RocketViewModel: ObservableObject {
    
    
    var manager = DataManager()
    
    @Published var roketArray = [rroket]
    @Published var launchArray: [LaunchModel] = []
    @Published var rocketLaunchArray: [returnModel] = []
    @Published var requestRocket: [POSModel] = [POSModel.share]
    @Published var isMetricHeight: Bool = true
    @Published var isMetricDiametr: Bool = true
    @Published var isMetricMass: Bool = true
    @Published var isMetricUsefulWeight: Bool = true
    @Published var roket1 = RocketModel.share
    @Published var isPreference: Bool = false
    @Published var preferenceArray: [Bool] = [true,true,true,true]
    var cancellables = Set<AnyCancellable>()
    
    static var rroket = RocketModel.share 
    
    
    
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
    
    func getData() {
        manager.$POSTLaunch
            .sink { [weak self] launch in
                self?.requestRocket = launch
            }
            .store(in: &cancellables)
        
        manager.$decodedLaunch
            .sink { [weak self] launch in
                self?.launchArray = launch
            }
            .store(in: &cancellables)
        
        manager.$returnedJSON
            .sink { [weak self] launch in
                self?.rocketLaunchArray = launch
            }
            .store(in: &cancellables)
    }
    
    func sortedLaunches(model: RocketModel) -> [LaunchModel] {
        let sortedArray = launchArray
                                .filter({$0.upcoming == false})
                                .filter({$0.rocket == model.id})
        return sortedArray
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
        getData()
    }
}
