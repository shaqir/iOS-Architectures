//
//  StockListView.swift
//  LiveStockDemo
//
//  Created by Sakir Saiyed on 2025-06-29.
//

import SwiftUI

struct StockListView: View {
    @StateObject private var viewModel = StockListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.stocks) { stock in
                HStack {
                    Text(stock.symbol)
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", stock.price))
                        .foregroundColor(stock.isPriceUp ? .green : .red)
                }
            }
            .navigationTitle("📈 Live Stocks")
        }
    }
}
