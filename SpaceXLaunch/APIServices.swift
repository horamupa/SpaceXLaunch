//
//  APIServices.swift
//  SpaceXLaunch
//
//  Created by MM on 16.08.2022.
//

import Foundation

enum ApiService {
    static func fetch<T: Decodable>(from url: URL) async throws -> [T] {
        let (todoData, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let result = try decoder.decode([T].self, from: todoData)
        
        return result
    }
    
    
//    static funk fetchTodos() async throws -> [String] {
//        guard let url = URL(string: "") else {
//            return []
//        }
//        
//        return try await ApiService
//            .fetch(from: url)
//    }
}
