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

    func testAPIServiceFetchSuccess() {
        let apiService = APIService()
        let expectation = XCTestExpectation(description: "Fetched products")

        apiService.fetch("https://dummyjson.com/products?limit=1")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { (response: ProductResponse) in
                XCTAssertGreaterThan(response.products.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3.0)
    }
}
