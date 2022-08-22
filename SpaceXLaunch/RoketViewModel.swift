////
////  RoketViewModel.swift
////  SpaceXLaunch
////
////  Created by MM on 16.08.2022.
////
//
//import Foundation
//import SwiftUI
//import Combine
//
//
//class RoketViewModel: ObservableObject {
//
//    // паблишер храниться отдельно, а не в классе, поэтому не знает, что он кодабл.
//    //поэтому мы создаём енам с подсказками, какие переменные кодировать
//    //мы говорим, сохрани проперти нейм как
////    private enum MyKeys: CodingKey {
////        case roketsArray
////    }
////    static let rroket = RoketModel(name: "name", active: false, stages: 3, boosters: 2, costPerLaunch: 23, successRatePct: 43, firstFlight: "Tommorow", country: "USA", company: "SpaceX", wikipedia: "gogo", spaceXDescription: "gogo", id: "123")
//
//    @Published var roketsArray: [RoketModel] = [rroket, rroket, rroket, rroket]
////    @Published var name: String = "RoketName"
////    static var rokets: RoketModel { loadData(RoketModel())}
//
//
//    //потом создаём контейнер, который позволит читать все наши пропертис
//    
////    init() { }
////
////    required init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: MyKeys.self)
////        roketsArray = try container.decode([RoketModel].self, forKey: .roketsArray)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: MyKeys.self)
////        try container.encode(roketsArray, forKey: .roketsArray)
////    }
//
//    func loadJSON() async {
//        guard let url = URL(string: RoketModel.url) else {
//            print("URL error")
//            return
//        }
//        print("\(url)")
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decodedData = try JSONDecoder().decode([RoketModel].self, from: data)
//            self.roketsArray = decodedData
//            DispatchQueue.main.async {
//                self.roketsArray = decodedData
//            }
//        } catch {
//            print("newtork data error")
//        }
//    }
//    
//}
