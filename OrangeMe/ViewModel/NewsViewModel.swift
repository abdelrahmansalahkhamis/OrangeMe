//
//  NewsViewModel.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 13/08/2023.
//

import Foundation
import Combine


class NewsViewModel: ObservableObject{

    @Published var news: [Article] = []

    @Published var isRefreshing: Bool = false

    @Published var hasError: Bool = false
    var error: Error?

    var bag = Set<AnyCancellable>()

    func fetchNews(){
        if let url = URL(string: FREE_DOMAIN){
            isRefreshing = true
            hasError = false
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap ({ res in
                    guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                        throw NetworkingError.invalidStatusCode
                    }
                    let decoder = JSONDecoder()
                    guard let fetchedData = try? decoder.decode(Welcome.self, from: res.data) else{
                        throw NetworkingError.failedToDecode
                    }
                    return fetchedData.articles

                })
                .sink { [weak self] res in
                    defer {
                        self?.isRefreshing = false
                    }
                    switch res{
                    case .failure(let error):
                        self?.hasError = true
                        self?.error = NetworkingError.custom(error: error)
                        break
                    default: break
                    }

                } receiveValue: { [weak self] news in
                    self?.news = news
                }
                .store(in: &bag)

        }
    }

    func searchFor(string query: String){
        if let url = URL(string: "https://newsapi.org/v2/everything?q=\(query)&from=2023-08-13&sortBy=publishedAt&apiKey=a874e9bc143c471c80b056a3914aa6a1"){
            isRefreshing = true
            hasError = false
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap ({ res in
                    guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                        throw NetworkingError.invalidStatusCode
                    }
                    let decoder = JSONDecoder()
                    guard let fetchedData = try? decoder.decode(Welcome.self, from: res.data) else{
                        throw NetworkingError.failedToDecode
                    }
                    return fetchedData.articles

                })
                .sink { [weak self] res in
                    defer {
                        self?.isRefreshing = false
                    }
                    switch res{
                    case .failure(let error):
                        self?.hasError = true
                        self?.error = NetworkingError.custom(error: error)
                        break
                    default: break
                    }

                } receiveValue: { [weak self] news in
                    self?.news = news
                }
                .store(in: &bag)

        }
    }
}

extension NewsViewModel {
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
