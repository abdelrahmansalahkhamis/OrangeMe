//
//  MockNewsAPIService.swift
//  OrangeMeUITests
//
//  Created by Abdelrahman Salah on 15/08/2023.
//

import Foundation
@testable import OrangeMe
import Combine


//class MockNewsAPIServiceImp: NewsAPIService {
//
//    var fetchNewsResult: AnyPublisher<NewsModel, Error>?
//    func fetchNews() -> AnyPublisher<NewsModel, Error> {
//        let url = URL(string: FREE_DOMAIN)!
//        return URLSession
//            .shared
//            .dataTaskPublisher(for: url)
//            .receive(on: DispatchQueue.main)
//            .tryMap({ res in
//                guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
//                    throw NetworkingError.invalidStatusCode
//                }
//                let decoder = JSONDecoder()
//                guard let fetchedData = try? decoder.decode(NewsModel.self, from: res.data) else{
//                    throw NetworkingError.failedToDecode
//                    //throw ""
//                }
//                return fetchedData
//            })
//            //.map({$0.data})
//            //.decode(type: NewsModel.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//}
//
//extension MockNewsAPIServiceImp {
//    enum NetworkingError: LocalizedError {
//        case custom(error: Error)
//        case failedToDecode
//        case invalidStatusCode
//
//        var errorDescription: String? {
//            switch self{
//            case .custom(error: let error):
//                return error.localizedDescription
//            case .failedToDecode:
//                return "Failed to decode response"
//            case .invalidStatusCode:
//                return "Request fails within an invalid range"
//            }
//        }
//    }
//}
