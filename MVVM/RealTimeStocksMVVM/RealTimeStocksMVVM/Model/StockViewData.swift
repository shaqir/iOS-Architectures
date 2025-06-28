//
//  StockViewData.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import Foundation
// MARK: - ViewModel Adapter

struct StockViewData: Identifiable {
    let id = UUID()
    let symbol: String
    let price: String
    let isPriceUp: Bool

    init(stock: Stock) {
        self.symbol = stock.symbol
        self.price = StockViewData.formatPrice(stock.price)
        self.isPriceUp = stock.isPriceUp
    }
    
    private static func formatPrice(_ value: Double) -> String {
           let formatter = NumberFormatter()
           formatter.numberStyle = .currency
           formatter.locale = Locale.current
           return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
       }
}

