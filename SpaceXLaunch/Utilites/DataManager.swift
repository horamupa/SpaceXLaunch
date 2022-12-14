//
//  DataManager.swift
//  SpaceXLaunch
//
//  Created by MM on 22.09.2022.
//

import SwiftUI
import Combine

class DataManager: ObservableObject {
    
    static var shared = DataManager()
    
    private init() {
        fetchLaunch()
    }
    
//    @Published var returnedLaunches: [Doc] = []
    @Published var returnedLaunchData: [LaunchModel] = []
    
    var cansellables = Set<AnyCancellable>()
    
    private var urlRocket = URL(string: "https://api.spacexdata.com/v4/rockets")!
    private var urlLaunch = URL(string: "https://api.spacexdata.com/v4/launches")!
    private var urlQuery = URL(string: "https://api.spacexdata.com/v4/launches/query")!
    
    
    /// Download JSON with Rocket Info using async
    func DownloadRockets() async throws -> [RocketModel]? {
        
        do {
            let (data, response) = try await URLSession(configuration: .default).data(from: urlRocket)
            let jsonData = try responseHandler(data: data, response: response)
            return jsonData
        } catch {
            throw error
        }
    }
    
    /// Download JSON with Launch Info using POST request and Combine
//    private func downloadLaunchPOST() {
//
//        let parameters: [String: Any] = [
//            "upcoming": false
//        ]
//
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
//            // create post request
//            var request = URLRequest(url: urlQuery)
//            request.httpMethod = "POST"
//            request.httpBody = jsonData
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap(combineHandler)
//            .decode(type: ReturnedLaunchModel.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink { (compeletion) in
//                print("Compeletion:\(compeletion)")
//            } receiveValue: { [weak self] (returnData) in
//                self?.returnedLaunchData.append(returnData)
//                self?.returnedLaunches.append(contentsOf: returnData.docs)
//            }
//            .store(in: &cansellables)
//
//        } catch {
//            let error = error
//            print(error.localizedDescription)
//        }
//    }
    
    /// Regular URLResponse handler
    private func responseHandler(data: Data?, response: URLResponse?) throws -> [RocketModel]? {
        guard
            let data = data,
            let json = try? JSONDecoder().decode([RocketModel].self, from: data),
            let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return json
    }
    
    /// Combine response handler
    private func combineHandler(compeletion: URLSession.DataTaskPublisher.Output ) throws -> Data {
        guard
            let responce = compeletion.response as? HTTPURLResponse,
            responce.statusCode >= 200 && responce.statusCode <= 300 else {
            print("Bad Response")
            throw URLError(.badServerResponse)
        }
        return compeletion.data
    }
    
        func fetchLaunch() {

            URLSession.shared.dataTaskPublisher(for: urlLaunch)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap(combineHandler)
                .decode(type: [LaunchModel].self, decoder: JSONDecoder())
                .sink { (compeletion) in
                    print("Compeletion:\(compeletion)")
                } receiveValue: { [weak self] (result) in
                    self?.returnedLaunchData = result
                }
                .store(in: &cansellables)
        }

}
