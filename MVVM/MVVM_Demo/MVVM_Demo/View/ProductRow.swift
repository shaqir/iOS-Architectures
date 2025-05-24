//
//  ProductRow.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView().frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(product.title).font(.headline)
                Text(product.description).font(.subheadline).foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}
 
