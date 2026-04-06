//
//  APIEndpoint.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://dummyjson.com"

    static func products(limit: Int, skip: Int) -> String {
        "\(baseURL)/products?limit=\(limit)&skip=\(skip)"
    }

    static func searchProducts(query: String, limit: Int, skip: Int) -> String {
        "\(baseURL)/products/search?q=\(query)&limit=\(limit)&skip=\(skip)"
    }
}
