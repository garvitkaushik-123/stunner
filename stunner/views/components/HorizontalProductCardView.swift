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
        VStack(alignment: .leading, spacing: 8) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.visbyMedium(size: 14))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("₹\(String(format: "%.2f", product.price))")
                    .font(.visbyLight(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
        }
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
