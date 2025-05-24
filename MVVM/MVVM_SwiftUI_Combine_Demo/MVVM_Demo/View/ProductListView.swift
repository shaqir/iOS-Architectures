//
//  PostListView.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//
import SwiftUI
import SwiftUI

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.products) { product in
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: product.thumbnail)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(8)
                            case .failure:
                                Image(systemName: "photo")
                                    .frame(width: 60, height: 60)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.title)
                                .font(.headline)
                            Text(product.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 4)
                    .onAppear {
                        if product == viewModel.products.last {
                            viewModel.fetchProducts()
                        }
                    }
                }
                
                if viewModel.products.isEmpty && viewModel.errorMessage == nil {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Products")
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
