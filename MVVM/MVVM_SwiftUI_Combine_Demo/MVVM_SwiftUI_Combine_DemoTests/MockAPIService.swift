//
//  MockAPIService.swift
//  MVVM_SwiftUI_Combine_DemoTests
//
//  Created by Sakir Saiyed on 23/05/25.
//

import Foundation
import Combine
@testable import MVVM_SwiftUI_Combine_Demo

class MockAPIService: APIServiceProtocol {
    var shouldReturnError = false
    var mockProducts: [Product] = []

    func fetch<T: Decodable>(_ endpoint: String) -> AnyPublisher<T, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        if let response = ProductResponse(products: mockProducts, total: 100, skip: 0, limit: 10) as? T {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
}
