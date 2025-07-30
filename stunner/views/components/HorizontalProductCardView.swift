//
//  HorizontalProductCardView.swift
//  stunner
//
//  Created by Garvit Kaushik on 29/07/25.
//

import Swift
import SwiftUI

struct HorizontalProductCardView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipped()
                .cornerRadius(8)

            Text(product.name)
                .font(.subheadline)
                .lineLimit(1)

            Text("₹\(product.price, specifier: "%.2f")")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 140)
    }
}


struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Double

    static let sampleProducts: [Product] = [
        Product(name: "T-Shirt", imageName: "product1", price: 499),
        Product(name: "Sneakers", imageName: "product2", price: 1999),
        Product(name: "Backpack", imageName: "product3", price: 899),
        Product(name: "Wrist Watch", imageName: "product4", price: 2599),
        Product(name: "Headphones", imageName: "product5", price: 1599),
        Product(name: "Sunglasses", imageName: "product6", price: 799)
    ]
}
