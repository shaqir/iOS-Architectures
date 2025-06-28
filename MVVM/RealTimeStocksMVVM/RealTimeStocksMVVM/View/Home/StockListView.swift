//
//  StockListView.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import SwiftUI
import Combine

// MARK: - View

struct StockListView: View {
    @ObservedObject var viewModel = MarketViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List(viewModel.filteredStocks) { stock in
                    NavigationLink(destination: StockDetailView(stock: stock)) {
                        StockRowView(stock: stock)
                    }
                }
            }
            .navigationTitle("📈 Stocks Live")
        }
    }
}
