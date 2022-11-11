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
    @State var sortedArray: [LaunchModel] = []
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if sortedArray.count > 0 {
                        ForEach(sortedArray) { launch in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(launch.name)")
                                        .font(.title2)
                                        .font(.labGrotesque(.semibold))
                                        .foregroundColor(.white)
                                    Text("\(launch.dateUTC)")
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text("🚀")
                                    .font(.largeTitle)
                                    .scaleEffect(1.5)
                                    .rotationEffect(Angle(degrees: launch.success ?? true ? 0 : 180))
                                    .overlay(alignment: .bottomTrailing) {
                                        ZStack{
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                                .opacity(launch.success ?? true ? 1 : 0)
                                            Image(systemName: "multiply")
                                                .foregroundColor(.red)
                                                .opacity(launch.success ?? true ? 0 : 1)
                                        }
                                        .padding(3)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                    }
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
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(model2: dev.roket)
            .environmentObject(dev.homeVM)
    }
}
