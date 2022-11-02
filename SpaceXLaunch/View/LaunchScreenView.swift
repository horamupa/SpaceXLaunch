//
//  LaunchScreenView.swift
//  SpaceXLaunch
//
//  Created by MM on 16.08.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var vm: RocketViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                ForEach(vm.launchArray) { launch in
                    HStack {
                        VStack {
                            Text("\(launch.name)")
                                .foregroundColor(.white)
                            Text("\(launch.rocket.rawValue)")
                                .foregroundColor(.white)
//                            Text("\(launch.dateUTC)")
//                                .foregroundColor(.white)
                            //                        Text(vm.launchArray.first?.name ?? "Nothin")
                            //                        Text(vm.launchArray[0].success ?? true ? "True" : "False")
                            //                        Text("\(vm.launchArray[0].rocket.rawValue)")
                            //                        Text("\(vm.launchArray[0].dateUTC)")
                        }
                    }
                }
            }
        }
    }
        
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(dev.homeVM)
    }
}
