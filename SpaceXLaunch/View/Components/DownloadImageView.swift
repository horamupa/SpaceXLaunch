//
//  DownloadImageView.swift
//  SpaceXLaunch
//
//  Created by MM on 24.11.2022.
//

import SwiftUI

struct DownloadImageView: View {
    
    @StateObject var vm: DownloadImageViewModel
//    var url: String
    
    init(url: String) {
//        self.url = url
        _vm = StateObject(wrappedValue: DownloadImageViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
            } else {
             ProgressView()
            }
        }
    }
}

//struct DownloadImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadImageView(url: "https://hws.dev/img/logo.png")
//    }
//}
