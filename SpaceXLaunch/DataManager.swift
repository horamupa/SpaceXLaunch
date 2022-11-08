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
        fetchLaunch()
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
    
    func fetchLaunch() {

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
        }
    
    func networkingPost() {
        
//
//
//        let parameterDictionary: [String: Any] = [
//            "query":[
//                "upcoming": true,
//                "rocket": "5e9d0d95eda69973a809d1ec"
//            ],
//            "options":[
//                "limit": 1]
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary)
//
//        // create post request
//        var request = URLRequest(url: urlLaunch)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        // insert json data to the request
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            guard let incomingData = try? JSONDecoder().decode(RequestLaunch.self, from: data) else {
//                print("BadJson decode")
//                return}
//            self.POSTLaunch.append(incomingData)
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
////                print(responseJSON) //Code after Successfull POST Request
//            }
//        }
//
//        task.resume()
    }
}
