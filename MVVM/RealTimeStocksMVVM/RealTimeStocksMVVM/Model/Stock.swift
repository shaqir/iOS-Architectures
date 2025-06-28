//
//  Stock.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import SwiftUI
import Combine

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let price: Double
    let isPriceUp: Bool
}

extension Stock {
    func toViewData() -> StockViewData {
        .init(stock: self)
    }
}

