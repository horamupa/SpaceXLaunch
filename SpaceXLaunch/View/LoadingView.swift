//
//  LoadingView.swift
//  SpaceXLaunch
//
//  Created by MM on 14.11.2022.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isAnimate: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Image("Union")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .offset(y: isAnimate ? -20 : 0)
                Text("Loading")
                    .foregroundColor(.white)
                    .font(.labGrotesque(.medium, size: 25))
            }
        }
        .animation(.easeIn(duration: 2).repeatForever(), value: isAnimate)
        .onAppear { isAnimate = true }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
