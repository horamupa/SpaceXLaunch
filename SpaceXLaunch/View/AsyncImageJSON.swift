//
//  AsyncImageComponent.swift
//  SpaceXLaunch
//
//  Created by MM on 17.08.2022.
//

import SwiftUI

struct AsyncImageJSON: View {
    
    @ObservedObject var viewModel: RocketViewModel
    
    var body: some View {
        
        AsyncImage(url: URL(string: viewModel.roketArray[0].flickrImages[0])) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
    }
}
//
//struct AsyncImageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageJSON(urlFromJson: .constant("go"))
//    }
//}
