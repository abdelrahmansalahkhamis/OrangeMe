//
//  NetworkCall.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 13/08/2023.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()

    var bag = Set<AnyCancellable>()

    func fetchNews(){
        if let url = URL(string: FREE_DOMAIN){
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap ({ res in
                    guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                        throw NetworkingError.invalidStatusCode
                    }
                    let decoder = JSONDecoder()

                    let data = res.data
                       do {
                          // process data
                           let decodedData = try decoder.decode(Welcome.self, from: data)
                           print("decodedData is :- \(decodedData)")
                       }
                    catch  {
                          print(error)
                       }
//                    guard let _ = try? decoder.decode([Article].self, from: res.data) else{
//                        throw NetworkingError.failedToDecode
//                    }

                })
                .sink { [weak self] res in
                    defer {

                    }
                    switch res{
                    case .failure(let error):
                        return
                        //return NetworkingError.custom(error: error)
                    case .finished:
                        print("res :-- \(res)")
                    default: break
                    }

                } receiveValue: { [weak self] news in
                    print("fetched news are :- \(news)")
                }
                .store(in: &bag)

        }
    }
}


extension NetworkManager {
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
