//
//  ImageComponent.swift
//  SpaceXLaunch
//
//  Created by MM on 17.08.2022.
//

import SwiftUI

struct ImageComponent: View {
    
    @Binding var urlFromJSON: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlFromJSON)) { phase in
            if let image = phase.image {
                image.resizable().scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image")
            } else {
                ProgressView()
            }
        }
//        .frame(width: 200, height: 200)
    }
}
//
//struct ImageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageComponent()
//    }
//}
