//
//  CartViewModel.swift
//  stunner
//
//  Created by Garvit Kaushik on 29/07/25.
//

import Foundation
internal import Combine

class CartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItem] = [
        CartItem(name: "Noise Smart Watch", price: 1999.0, imageName: "watch1"),
        CartItem(name: "Redmi Earbuds", price: 899.0, imageName: "earbuds1")
    ]
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }
}
