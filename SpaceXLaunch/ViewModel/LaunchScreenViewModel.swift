//
//  LaunchScreenViewModel.swift
//  SpaceXLaunch
//
//  Created by MM on 24.11.2022.
//

import SwiftUI
import Combine

class LaunchScreenViewModel: ObservableObject {
    
    @Published var launchArray: [Doc] = []
    
    var manager = DataManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchLaunch()
    }
    
    /// sink rocketLaunchArray from FileManager with Combine
    func fetchLaunch() {
        manager.$returnedLaunches
            .sink { [weak self] launch in
                self?.launchArray = launch
                print("Sink OK")
            }
            .store(in: &cancellables)
    }
}
