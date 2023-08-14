//
//  EndPoint.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 14/08/2023.
//
import Foundation


enum EndPoint{
    case news(publishedAt: String, apiKey: String)
    case search(publishedAt: String, apiKey: String)
}

extension EndPoint{
    enum MethodType{
        case GET
        case POST(data: Data?)
    }
}

extension EndPoint{
    var host: String {
        DOMAIN
    }

    var path: String{
        switch self {
        case .news(let publishedAt, let apiKey):
            return "v2/everything?q=tesla&from=\(publishedAt)&sortBy=publishedAt&apiKey=\(apiKey)"
        case .search(let publishedAt, let apiKey):
            return "v2/everything?q=tesla&from=\(publishedAt)&sortBy=publishedAt&apiKey=\(apiKey)"
        }
    }

    var methodType: MethodType{
        switch self {
        case .news:
            return .GET
        case .search:
            return .GET
        }
    }

    var queryItems: [String: String]?{
        switch self {
        case .news(let publishedAt, let apiKey):
            return [
                "publishedAt": "\(publishedAt)",
                "apiKey": "\(apiKey)"
            ]
        case .search(let publishedAt, let apiKey):
            return [
                "publishedAt": "\(publishedAt)",
                "apiKey": "\(apiKey)"
            ]
        }
    }

}

extension EndPoint{
    var url: URL?{
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path

        let requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        urlComponent.queryItems = requestQueryItems
        return urlComponent.url
    }
}
