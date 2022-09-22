//
//  DataManager.swift
//  SpaceXLaunch
//
//  Created by MM on 22.09.2022.
//

import SwiftUI

class DataManager {
    
    private var url = URL(string: "https://api.spacexdata.com/v4/rockets")!
    
    func fetchJSON() async throws -> [RoketModel]? {
        
            do {
                let (data, response) = try await URLSession(configuration: .default).data(from: url)
                let jsonData = try decodeJsonHandler(data: data, response: response)
                return jsonData
            } catch {
                throw error
            }
        
    }
    
    func decodeJsonHandler(data: Data?, response: URLResponse?) throws -> [RoketModel]? {
        guard
            let data = data,
            let json = try? JSONDecoder().decode([RoketModel].self, from: data),
            let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return json
    }
    
    
}
