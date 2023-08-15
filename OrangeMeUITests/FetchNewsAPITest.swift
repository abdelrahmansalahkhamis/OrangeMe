//
//  FetchNewsTest.swift
//  OrangeMeUITests
//
//  Created by Abdelrahman Salah on 15/08/2023.
//

import XCTest
import Combine

@testable import OrangeMe

final class FetchNewsAPITest: XCTestCase {

    var systemUnderTest: NewsViewModel!
    var newsAPIService: NewsAPIService!

    override func setUp() {
        super.setUp()
        //newsAPIService = MockNewsAPIServiceImp()
        systemUnderTest = NewsViewModel(newsAPIService: newsAPIService)
    }

    override func tearDown() {
        systemUnderTest = nil
        newsAPIService = nil
    }

    func testUpdateUI_onAPIError_isNotCalled(){
        //newsAPIService.fetchNewsResult = Fail(error: NSError()).eraseToAnyPublisher()

        //systemUnderTest.displayNews()
        XCTAssertEqual(systemUnderTest.news.count, 0)

    }

    func testUpdateUI_onAPISuccess_isCalled(){
        let news: [Article] = [
            Article(source: Source(id: nil, name: "Biztoc.com"), author: "nytimes.com", title: "Making Sure Federal Climate Money Helps Us All", description: "After President Biden signed the Inflation Reduction Act one year ago, Teslas began popping up everywhere in Cambridge, Mass., where I live. More solar panels appeared on my neighbors’ roofs. Mini split units that heat and cool became all the rage. In wealthy…", url: "https://biztoc.com/x/e9fcc4733ee1dfd9", urlToImage: "https://c.biztoc.com/p/e9fcc4733ee1dfd9/og.webp", publishedAt: "2023-08-15T19:03:08Z", content: "After President Biden signed the Inflation Reduction Act one year ago, Teslas began popping up everywhere in Cambridge, Mass., where I live. More solar panels appeared on my neighbors roofs. Mini spl… [+289 chars]")
        ]
        //newsAPIService.fetchNewsResult = CurrentValueSubject(news).eraseToAnyPublisher()

        systemUnderTest.displayNews()

        XCTAssertEqual(systemUnderTest.news.count, 1)
        XCTAssertEqual(systemUnderTest.news[0].author, "nytimes.com")
    }

}
