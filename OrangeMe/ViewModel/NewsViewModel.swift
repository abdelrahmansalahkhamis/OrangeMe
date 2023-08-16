//
//  NewsViewModel.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 13/08/2023.
//

import Foundation
import Combine


class NewsViewModel: ObservableObject{

    private let newsAPIService: NewsAPIService

    init(newsAPIService: NewsAPIService = NewsAPIServiceImp()) {
        self.newsAPIService = newsAPIService
    }

    @Published var news: [Article] = []
    @Published var isRefreshing: Bool = false

    var bag = Set<AnyCancellable>()

    func displayNews(searchString: String = "tesla"){
        isRefreshing = true
        newsAPIService.fetchNews(searchString: searchString)
            .sink { [weak self] _ in
                do{ self?.isRefreshing = false }
            } receiveValue: { [weak self] news in
                self?.news = news.articles.map({$0})
            }
            .store(in: &bag)
    }
}
