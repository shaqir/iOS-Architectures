//
//  ContentView.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StockListView(viewModel: MarketViewModel())
    }
}

#Preview {
    ContentView()
}
