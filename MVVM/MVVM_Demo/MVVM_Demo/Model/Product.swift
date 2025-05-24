//
//  Post.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//

import Foundation

struct Product: Identifiable, Decodable, Equatable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: String
}

struct ProductResponse: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
