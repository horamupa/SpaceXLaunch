//
//  DownloadImageViewModel.swift
//  SpaceXLaunch
//
//  Created by MM on 24.11.2022.
//

import SwiftUI
import Combine

class DownloadImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var url: String
    var cancellables = Set<AnyCancellable>()
    var manager = CacheManager.share
    
    init(url: String) {
        self.url = url
        getImage()
    }
    
    /// try to get image from cache. Downloading it if it's fail.
    func getImage() {
        if let image = manager.getItem(name: self.url) {
            self.image = image
        } else {
            downloadImage()
        }
    }
    
    func downloadImage() {
        guard
            let url = URL(string: url)
        else {
            print("URL link problem")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(combineHandler)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] receiveData in
                guard
                    let self = self,
                    let image = UIImage(data: receiveData)
                else {
                    print("Data to Image error")
                    return
                }
                self.image = image
                self.manager.addItem(name: self.url, image: image)
            }
            .store(in: &cancellables)
        
    }
    
    private func combineHandler(compeletion: URLSession.DataTaskPublisher.Output ) throws -> Data {
        guard
            let responce = compeletion.response as? HTTPURLResponse,
            responce.statusCode >= 200 && responce.statusCode <= 300 else {
            print("Bad Response")
            throw URLError(.badServerResponse)
        }
        return compeletion.data
    }
}
