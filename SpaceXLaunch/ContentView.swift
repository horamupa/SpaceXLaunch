//
//  ContentView.swift
//  SpaceXLaunch
//
//  Created by MM on 15.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                NavigationView {
                    RoketView()
//                        .frame(height: screen.height)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

