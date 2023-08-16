//
//  MockNewsAPIService.swift
//  OrangeMeUITests
//
//  Created by Abdelrahman Salah on 15/08/2023.
//

import Foundation
@testable import OrangeMe
import Combine


class MockNewsAPIServiceImp: NewsAPIService {
    func fetchNews(searchString: String) -> AnyPublisher<NewsModel, Error> {
        let stringURL = "\(DOMAIN)/v2/everything?q=\(searchString)&from=2023-08-13&sortBy=publishedAt&apiKey=\(API_KEY)"
        let url = URL(string: stringURL)!
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

extension MockNewsAPIServiceImp {
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
