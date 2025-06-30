//
//  Stock.swift
//  LiveStockDemo
//
//  Created by Sakir Saiyed on 2025-06-29.
//

import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    var price: Double
    var isPriceUp: Bool
}
