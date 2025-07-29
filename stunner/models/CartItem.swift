//
//  CartItem.swift
//  stunner
//
//  Created by Garvit Kaushik on 29/07/25.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let imageName: String
}
