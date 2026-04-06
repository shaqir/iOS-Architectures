//
//  APIServiceTests.swift
//  MVVM_SwiftUI_Combine_DemoTests
//
//  Created by Sakir Saiyed on 23/05/25.
//

import XCTest
import Combine
@testable import MVVM_SwiftUI_Combine_Demo

final class APIServiceTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    func testFetchReturnsProducts() {
        let mockService = MockAPIService()
        mockService.mockProducts = [
            Product(id: 1, title: "Test", description: "Desc", thumbnail: "https://example.com/img.png")
        ]

        let expectation = XCTestExpectation(description: "Fetched products")

        let publisher: AnyPublisher<ProductResponse, Error> = mockService.fetch("https://dummyjson.com/products?limit=1")
        publisher
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.products.count, 1)
                XCTAssertEqual(response.products.first?.title, "Test")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchReturnsError() {
        let mockService = MockAPIService()
        mockService.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Received error")

        let publisher: AnyPublisher<ProductResponse, Error> = mockService.fetch("https://dummyjson.com/products")
        publisher
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected error but got value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
