//
//  DataManager.swift
//  SpaceXLaunch
//
//  Created by MM on 22.09.2022.
//

import SwiftUI
import Combine

class DataManager: ObservableObject {
    
//    static var instance = DataManager()
    
    @Published var decodedLaunch: [LaunchModel] = []
    @Published var POSTLaunch: [POSModel] = []
    var filtredLaunch: [LaunchModel] = []
    var cansellables = Set<AnyCancellable>()
    
    private var urlRocket = URL(string: "https://api.spacexdata.com/v4/rockets")!
    private var urlLaunch = URL(string: "https://api.spacexdata.com/v4/launches")!
    
    init() {
        fetchJSON2()
        POSTLaunch = fetchLaunch()
    }
    
    func fetchJSON() async throws -> [RocketModel]? {
        
        do {
            let (data, response) = try await URLSession(configuration: .default).data(from: urlRocket)
            let jsonData = try decodeJsonHandler(data: data, response: response)
            return jsonData
        } catch {
            throw error
        }
        
    }
    
    func decodeJsonHandler(data: Data?, response: URLResponse?) throws -> [RocketModel]? {
        guard
            let data = data,
            let json = try? JSONDecoder().decode([RocketModel].self, from: data),
            let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return json
    }
    
    func fetchJSON2() {
        
        URLSession.shared.dataTaskPublisher(for: urlLaunch)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(combineHandler)
            .decode(type: [LaunchModel].self, decoder: JSONDecoder())
            .sink { (compeletion) in
                print("Compeletion:\(compeletion)")
            } receiveValue: { [weak self] (result) in
                self?.decodedLaunch = result
            }
            .store(in: &cansellables)
    }
    
    func combineHandler(compeletion: URLSession.DataTaskPublisher.Output ) throws -> Data {
        guard
            let responce = compeletion.response as? HTTPURLResponse,
            responce.statusCode >= 200 && responce.statusCode <= 300 else {
            throw URLError(.badServerResponse)
        }
        return compeletion.data
    }
    
    func fetchLaunch() -> [POSModel] {

            let decoder = JSONDecoder()

            URLSession.shared.dataTaskPublisher(for: urlLaunch)
                .retry(1)
                .map(\.data)
                .decode(type: [POSModel].self, decoder: decoder)
                .replaceError(with: [POSModel.share])
                .receive(on: DispatchQueue.main)
                .sink { (compeletion) in
                    print("Compeletion:\(compeletion)")
                } receiveValue: { [weak self] (result) in
                    self?.POSTLaunch = result
                }
                .store(in: &cansellables)
        return self.POSTLaunch
    }
}
