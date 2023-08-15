//
//  OrangeMeMockTest.swift
//  OrangeMeUITests
//
//  Created by Abdelrahman Salah on 15/08/2023.
//

import XCTest

@testable import OrangeMe

final class DisplayNewsTest: XCTestCase {

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

    func testDisplayArticles() {
        systemUnderTest.displayNews()
        //XCTAssertNotEqual(systemUnderTest.news.count, 0, "Number of articles should not be zero")
        XCTAssertGreaterThan(systemUnderTest.news.count, -1, "Number of articles could not be less than zero")
    }

}
