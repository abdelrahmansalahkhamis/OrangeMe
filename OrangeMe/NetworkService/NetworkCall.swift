//
//  NetworkCall.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 13/08/2023.
//

import Foundation
import Combine

protocol NewsAPIService{
    func fetchNews() -> AnyPublisher<NewsModel, Error>
}

class NewsAPIServiceImp: NewsAPIService {
    func fetchNews() -> AnyPublisher<NewsModel, Error> {
        let url = URL(string: FREE_DOMAIN)!
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ res in
                guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw NetworkingError.invalidStatusCode
                }
                let decoder = JSONDecoder()
                guard let fetchedData = try? decoder.decode(NewsModel.self, from: res.data) else{
                    throw NetworkingError.failedToDecode
                }
                return fetchedData
            })
            .eraseToAnyPublisher()
    }
}


extension NewsAPIServiceImp {
    enum NetworkingError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode

        var errorDescription: String? {
            switch self{
            case .custom(error: let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Failed to decode response"
            case .invalidStatusCode:
                return "Request fails within an invalid range"
            }
        }
    }
}
