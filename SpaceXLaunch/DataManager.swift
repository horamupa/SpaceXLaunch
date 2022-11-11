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
    @Published var decodedLaunch2: [LaunchModel] = []
    @Published var POSTLaunch: [POSModel] = []
    @Published var returnedJSON: [returnModel] = []
    var filtredLaunch: [LaunchModel] = []
    var cansellables = Set<AnyCancellable>()
    
    private var urlRocket = URL(string: "https://api.spacexdata.com/v4/rockets")!
    private var urlLaunch = URL(string: "https://api.spacexdata.com/v4/launches")!
    private var urlQuery = URL(string: "https://api.spacexdata.com/v4/launches/query")!
    
    init() {
//        fetchRocket()
        fetchLaunch()
        apiCall()
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
    
//    func fetchRocket() {
//
//        URLSession.shared.dataTaskPublisher(for: urlLaunch)
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .tryMap(combineHandler)
//            .decode(type: [LaunchModel].self, decoder: JSONDecoder())
//            .sink { (compeletion) in
//                print("Compeletion:\(compeletion)")
//            } receiveValue: { [weak self] (result) in
//                self?.decodedLaunch = result
//            }
//            .store(in: &cansellables)
//    }
    
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
    
    private func apiCall() {
        let parameters: [String: Any] = [
            "upcoming": false,
            "rocket": "5e9d0d95eda69973a809d1ec"
        ]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // create post request
        var request = URLRequest(url: urlQuery)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: returnModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (compeletion) in
                print("Compeletion:\(compeletion)")
            } receiveValue: { [weak self] returnData in
                self?.returnedJSON.append(returnData)
            }

        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//
//                let obj = try decoder.decode(returnModel.self, from: data)
//
//            } catch {
//                print(error.localizedDescription)
//                print(String(describing: error))
//            }
//
//        }
//
//        task.resume()
        
    }
        
        
//
//
//
//        let jsonData = try? JSONEncoder().encode(parameters)
////        try? JSONEncoder().encode([rocketInfo.rocketSamplePOST])
//            var request = URLRequest(url: urlQuery)
//            request.httpMethod = "POST"
//            request.httpBody = jsonData
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            URLSession.shared.dataTaskPublisher(for: request)
//                .subscribe(on: DispatchQueue.global(qos: .background))
//                .tryMap(combineHandler)
//                .decode(type: [rocketInfo].self, decoder: JSONDecoder())
//                .subscribe(on: DispatchQueue.main)
//                .sink { (completion) in
//                    switch completion {
//                    case .finished:
//                        break
//                    case .failure(let error):
//                        print("Error to download \(error.localizedDescription)")
//                    }
//                } receiveValue: { [weak self] (translatedData) in
//                    self?.newLaunch = translatedData
//                    print("Ok")
//                }
//                .store(in: &cansellables)
//        }

//
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data = data, error == nil else {
//            print(error?.localizedDescription ?? "No data")
//            return
//        }
//        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//        if let responseJSON = responseJSON as? [String: Any] {
//            print(responseJSON)
//        }
//    }
//
//    task.resume()
}
