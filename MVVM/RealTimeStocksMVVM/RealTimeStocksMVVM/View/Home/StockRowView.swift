//
//  StockRowView.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-27.
//

import SwiftUICore

struct StockRowView: View {
    let stock: StockViewData

    var body: some View {
        HStack {
            Text(stock.symbol)
                .font(.headline)
            Spacer()
            Text(stock.price)
                .foregroundColor(stock.isPriceUp ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}

