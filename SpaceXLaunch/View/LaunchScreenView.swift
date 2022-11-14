//
//  LaunchScreenView.swift
//  SpaceXLaunch
//
//  Created by MM on 16.08.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var vm: RocketViewModel
    @State var model: RocketModel
    @State var sortedArray: [Doc] = []
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    
//                    if sortedArray.count > 0 {
                        ForEach(sortedArray) { launch in
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
                                    .frame(width: 30, height: 30)
//                                    .scaleEffect(1.5)
                                    .rotationEffect(Angle(degrees: launch.success ? 0 : 180))
                                    .overlay (
                                        ZStack(alignment: .bottomTrailing) {
                                            Circle()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(launch.success ? .green : .red)
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.white)
                                                .opacity(launch.success ? 1 : 0)
                                            Image(systemName: "multiply")
                                                .foregroundColor(.white)
                                                .opacity(launch.success ? 0 : 1)
                                        }
                                        , alignment: .bottomTrailing
                                    )
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
//                    }
//                    else {
//                        Text("Запусков за год небыло")
//                            .font(.largeTitle)
//                            .foregroundColor(.white)
//                            .padding(.top, 200)
//                    }
                }
            }
            .font(.labGrotesque(.medium, size: 20))
            .navigationTitle("\(model.name)")
//            .statusBarHidden(false)
        }
//        .navigationBarHidden(false)
        .onAppear {
            fetchRocketModel()
        }
    }
    init(model2: RocketModel) {
//        fetchRocketModel()
        self.model = model2
    }
    
    func fetchRocketModel() {
        self.sortedArray = vm.sortedLaunches(model: model)
        print("launchFetched")
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(model2: dev.roket)
            .environmentObject(dev.homeVM)
    }
}
