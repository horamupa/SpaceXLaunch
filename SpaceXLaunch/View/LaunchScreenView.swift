//
//  LaunchScreenView.swift
//  SpaceXLaunch
//
//  Created by MM on 16.08.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var vm: RocketViewModel
    var model: RocketModel
    var sortedArray: [LaunchModel] { vm.sortedLaunches(model: model) }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                ForEach(sortedArray) { launch in
                    HStack {
                        VStack {
                            Text("\(launch.name)")
                                .foregroundColor(.white)
                            Text("\(launch.rocket.rawValue)")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
        
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(model: dev.roket)
            .environmentObject(dev.homeVM)
    }
}
