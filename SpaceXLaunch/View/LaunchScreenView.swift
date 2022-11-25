//
//  LaunchScreenView.swift
//  SpaceXLaunch
//
//  Created by MM on 16.08.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @StateObject var vm: LaunchScreenViewModel
    var model: RocketModel
    
    init(model: RocketModel) {
        self.model = model
        _vm = StateObject(wrappedValue: LaunchScreenViewModel(model: model))
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if vm.sortedLaunch.count > 0 {
                        ForEach(vm.sortedLaunch) { launch in
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(launch.name)")
                                        .font(.title2)
                                        .font(.labGrotesque(.semibold))
                                        .foregroundColor(.white)
                                    Text("\(launch.dateUnix.intToDateFormatter())")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Image("Union")
                                    .scaleEffect(1.5)
                                    .overlay (
                                        ZStack {
                                            Circle()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(launch.success ?? true ? .green : .red)
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.white)
                                                .opacity(launch.success ?? true ? 1 : 0)
                                            Image(systemName: "multiply")
                                                .foregroundColor(.white)
                                                .opacity(launch.success ?? true ? 0 : 1)
                                        }.frame(alignment: .bottomTrailing)
                                    )
                                    .frame(alignment: .bottomTrailing)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                    else {
                        Text("Запусков за год небыло")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top, 200)
                    }
                }
            }
            .font(.labGrotesque(.medium, size: 20))
            .navigationTitle("\(model.name)")
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(model: dev.roket)
            .environmentObject(dev.homeVM)
    }
}
