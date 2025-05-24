//
//  ProductResponse.swift
//  MVVM_SwiftUI_Combine_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//

import Foundation

struct ProductResponse: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
