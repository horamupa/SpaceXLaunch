//
//  ContentView.swift
//  SpaceXLaunch
//
//  Created by MM on 15.08.2022.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel = RocketViewModel()
    
    @State private var update = UUID()
    
    var body: some View {
        
        TabView {
            
                ForEach(viewModel.roketArray, id: \.id) { model in
                    RoketView(model: model)
                        .tag(String(model.name))
            }
        }
            .tabViewStyle(.page)
            .background(.black)
            .ignoresSafeArea()
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .sheet(isPresented: $viewModel.isPreference) {
                    Preference(viewModel: viewModel)
            }
            .environmentObject(viewModel)
            .onAppear {
                Task {
                    await viewModel.fetchJSON()
                }
            }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

