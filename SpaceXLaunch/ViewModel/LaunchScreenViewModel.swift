//
//  LaunchScreenViewModel.swift
//  SpaceXLaunch
//
//  Created by MM on 24.11.2022.
//

import SwiftUI
import Combine

class LaunchScreenViewModel: ObservableObject {
    
    @Published var launchArray: [LaunchModel] = []
    @Published var sortedLaunch: [LaunchModel] = []
    
    var manager = DataManager.shared
    var cancellables = Set<AnyCancellable>()
    var model: RocketModel
    
    init(model: RocketModel) {
        self.model = model
        fetchLaunch()
        sortLaunch()
    }
    
    /// sink rocketLaunchArray from FileManager with Combine
    func fetchLaunch() {
        manager.$returnedLaunchData
            .sink { [weak self] launch in
                self?.launchArray = launch
                print("Sink OK")
            }
            .store(in: &cancellables)
    }
    
    func sortLaunch() {
        sortedLaunch = launchArray.filter { $0.rocket.rawValue == model.id }.reversed()
    }
}
