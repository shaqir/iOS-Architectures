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


