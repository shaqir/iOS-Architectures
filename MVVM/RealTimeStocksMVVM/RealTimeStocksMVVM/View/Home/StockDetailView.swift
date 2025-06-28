//
//  StockDetailView.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-27.
//

import SwiftUI

struct StockDetailView: View {
    let stock: StockViewData

    var body: some View {
        VStack(spacing: 20) {
            Text(stock.symbol)
                .font(.largeTitle)
            Text(stock.price)
                .font(.title)
                .foregroundColor(stock.isPriceUp ? .green : .red)
            Text(stock.isPriceUp ? "Price is up" : "Price is down")
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Details")
    }
}
