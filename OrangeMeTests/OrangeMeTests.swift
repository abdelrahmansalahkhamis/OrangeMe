//
//  OrangeMeTests.swift
//  OrangeMeTests
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import XCTest
import Combine
@testable import OrangeMe

final class OrangeMeTests: XCTestCase {

    var systemUnderTest: NewsViewModel!
    var mockNewsAPIService: MockNewsAPIServiceImp!

    var bag = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockNewsAPIService = MockNewsAPIServiceImp()
        systemUnderTest = NewsViewModel(newsAPIService: mockNewsAPIService)
    }

    override func tearDown() {
        systemUnderTest = nil
        mockNewsAPIService = nil
    }

    func testLoadNewsOnLaunch(){
        XCTAssertEqual(systemUnderTest.news.count, 0)
    }

    func testFetchNewsSuccess(){
        XCTAssertEqual(systemUnderTest.news.count, 0)
        let promise = expectation(description: "loading all news")
        systemUnderTest.displayNews()
        systemUnderTest.$news
            .sink { (completion) in
            XCTFail()
        } receiveValue: { news in
            if news.count == 100 {
                promise.fulfill()
            }
        }
        .store(in: &bag)
        wait(for: [promise], timeout: 5)
    }
}
