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
    @Published var returnedJSON: [Doc] = []
    @Published var returnedJSON2: [returnModel] = []
    
    var filtredLaunch: [LaunchModel] = []
    var cansellables = Set<AnyCancellable>()
    
    private var urlRocket = URL(string: "https://api.spacexdata.com/v4/rockets")!
    private var urlLaunch = URL(string: "https://api.spacexdata.com/v4/launches")!
    private var urlQuery = URL(string: "https://api.spacexdata.com/v4/launches/query")!
    
    init() {
//        fetchRocket()
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
            print("Bad Response")
            throw URLError(.badServerResponse)
        }
//        print("handler ok")
        return compeletion.data
    }
    
    private func apiCall() {
        let parameters: [String: Any] = [
            "upcoming": false
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            // create post request
            var request = URLRequest(url: urlQuery)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(combineHandler)
            .decode(type: returnModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
//            .sink { (compeletion) in
//                        print("Compeletion:\(compeletion)")
//                    } receiveValue: { [weak self] (result) in
//                        self?.returnedJSON2.append(result)
//                    }
            .sink { (compeletion) in
                print("Compeletion:\(compeletion)")
            } receiveValue: { [weak self] (returnData) in
                self?.returnedJSON2.append(returnData)
                self?.returnedJSON.append(contentsOf: returnData.docs)
            }
            .store(in: &cansellables)
            DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                print(self.returnedJSON.count)
                print(self.returnedJSON2.count)
            }
            
        } catch {
            let error = error
            print(error.localizedDescription)
        }
    }

}
