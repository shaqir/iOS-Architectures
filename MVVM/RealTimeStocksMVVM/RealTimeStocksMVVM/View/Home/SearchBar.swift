//
//  SearchBarView.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-27.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding([.horizontal, .top])
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView()
    }
}
