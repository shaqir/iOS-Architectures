//
//  ProductViewModelTests.swift
//  MVVM_SwiftUI_Combine_DemoTests
//
//  Created by Sakir Saiyed on 23/05/25.
//

import XCTest
import Combine
@testable import MVVM_SwiftUI_Combine_Demo

final class ProductViewModelTests: XCTestCase {

    var viewModel: ProductViewModel!
    var mockService: MockAPIService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        viewModel = ProductViewModel(apiService: mockService)
    }

    func testFetchProductsSuccess() {
        let mockService = MockAPIService()
        let mockProduct = Product(id: 1, title: "Test Product", description: "Description", thumbnail: "")
        mockService.mockProducts = [mockProduct]
        
        let viewModel = ProductViewModel(apiService: mockService)
        let expectation = XCTestExpectation(description: "Products fetched")

        // Add a Combine subscriber to observe state change
        let cancellable = viewModel.$products
            .dropFirst()
            .sink { products in
                if let firstTitle = products.first?.title {
                    XCTAssertEqual(firstTitle, "Test Product")
                    expectation.fulfill()
                }
            }

        viewModel.fetchProducts()

        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }

    func testFetchProductsFailure() {
        let expectation = XCTestExpectation(description: "Error received")

        mockService.shouldReturnError = true

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchProducts()

        wait(for: [expectation], timeout: 1.0)
    }
}
