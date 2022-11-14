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
    
    @Published var roketArray: [RocketModel] = []
    @Published var rocketLaunchArray: [Doc] = []
    @Published var roket1 = RocketModel.share
    @Published var isPreference: Bool = false
    @Published var preferenceArray: [Bool] = [true,true,true,true]
    @Published var isLoaded: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    static var rroket = RocketModel.share 
    
    
    // fetch with async
    func fetchRocket() async {
        do {
            if let decodedJSON = try await manager.DownloadRockets() {
                await MainActor.run(body: {
                    self.roketArray = decodedJSON
                    self.isLoaded = true
                })
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //fetch with combine
    func fetchLaunch() {
        
        manager.$returnedJSON
            .sink { [weak self] launch in
                self?.rocketLaunchArray = launch
                print("Sink OK")
            }
            .store(in: &cancellables)
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
//        preferenceArray = [isMetricHeight, isMetricDiametr, isMetricMass, isMetricUsefulWeight]
        setPreference()
        fetchLaunch()
    }

}
