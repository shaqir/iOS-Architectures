//
//  SearchBar.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search products...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}

