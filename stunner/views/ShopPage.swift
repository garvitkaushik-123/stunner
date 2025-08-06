import SwiftUI
internal import Combine

struct ShopPage: View {
    @Environment(\.presentationMode) var presentationMode

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            StunnerHeader(showBackButton: true) {
                presentationMode.wrappedValue.dismiss()
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ShopSectionGrid(title: "SELF CARE", products: Array(sampleProducts1.prefix(2)))
                    ShopSectionGrid(title: "BEST SELLERS", products: Array(sampleProducts2.prefix(2)))
                    ShopSectionGrid(title: "STUNNER DISCOUNT DEALS", products: Array(sampleProducts3.prefix(2)))
                }
                .padding(.horizontal, 12)
            }
            .background(Color.stunner)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Section Grid View (Vertical, not horizontal)
struct ShopSectionGrid: View {
    let title: String
    let products: [ShopProduct]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.visbyMedium(size: 15))
                .tracking(0.08 * 15)
            
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(products) { product in
                    ShopProductCard(product: product)
                }
            }
        }
    }
}

// MARK: - Card (Similar to BrandProductCard)
struct ShopProductCard: View {
    let product: ShopProduct

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()

                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(8)
            }

            VStack(spacing: 4) {
                Text(product.name.uppercased())
                    .font(.visbyMedium(size: 11))
                    .tracking(0.08 * 11)
                    .multilineTextAlignment(.center)

                HStack(spacing: 8) {
                    Text("₹\(Int(product.discountedPrice))")
                        .font(.visbyMedium(size: 9))

                    Text("₹\(Int(product.originalPrice))")
                        .font(.visbyMedium(size: 9))
                        .strikethrough()
                        .foregroundColor(Color(hex: "b0b0b0"))

                    let discount = Int(100 - (product.discountedPrice / product.originalPrice) * 100)
                    Text("\(discount)% OFF")
                        .font(.visbyMedium(size: 9))
                }
            }
        }
    }
}

struct ShopPage_Previews: PreviewProvider {
    static var previews: some View {
        ShopPage()
    }
}

import Foundation
import SwiftUI

class ShopProduct: Identifiable, ObservableObject {
    let id: UUID
    let name: String
    let brand: String
    let imageName: String
    let originalPrice: Double
    let discountedPrice: Double
    let deliveryTime: String?

    init(
        id: UUID = UUID(),
        name: String,
        brand: String,
        imageName: String,
        originalPrice: Double,
        discountedPrice: Double,
        deliveryTime: String? = nil
    ) {
        self.id = id
        self.name = name
        self.brand = brand
        self.imageName = imageName
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
        self.deliveryTime = deliveryTime
    }

    var discountPercentage: Int {
        guard originalPrice > 0 else { return 0 }
        return Int((1 - (discountedPrice / originalPrice)) * 100)
    }
}

let sampleProducts1: [ShopProduct] = [
    ShopProduct(name: "Rose & Jasmine Hair Cleanser", brand: "KAMA AYURVEDA", imageName: "selfcare1", originalPrice: 699, discountedPrice: 529, deliveryTime: "60 MINS"),
    ShopProduct(name: "Clinical Serum Foundation SPF 20", brand: "Clinique", imageName: "selfcare2", originalPrice: 1999, discountedPrice: 1699, deliveryTime: "2 HRS"),
    ShopProduct(name: "Depiderm Anti-Dark Spot Skin Serum", brand: "Uriage", imageName: "selfcare3", originalPrice: 1999, discountedPrice: 1699, deliveryTime: "2 HRS"),
    ShopProduct(name: "Foaming Cleanser & Face Wash", brand: "Olay", imageName: "selfcare4", originalPrice: 1999, discountedPrice: 1699, deliveryTime: "2 HRS")
]

let sampleProducts2: [ShopProduct] = [
    ShopProduct(name: "Full Sleeves Night Suit", brand: "Babyoye", imageName: "stundeal1", originalPrice: 12999, discountedPrice: 11099, deliveryTime: "60 MINS"),
    ShopProduct(name: "ARKS Baseball cap", brand: "ARKS", imageName: "stundeal2", originalPrice: 12999, discountedPrice: 11099, deliveryTime: "60 MINS"),
    ShopProduct(name: "Stanley Quencher", brand: "Stanley", imageName: "stundeal4", originalPrice: 12999, discountedPrice: 11099, deliveryTime: "60 MINS"),
    ShopProduct(name: "CHAPTER 2 BLACK JACKET", brand: "CHAPTER 2", imageName: "stundeal3", originalPrice: 5490, discountedPrice: 5050, deliveryTime: "60 MINS")
]

let sampleProducts3: [ShopProduct] = [
    ShopProduct(name: "TOM FORD BOIS PARFUM", brand: "TOM FORD", imageName: "product1", originalPrice: 17000, discountedPrice: 12999, deliveryTime: "2 HRS"),
    ShopProduct(name: "Earbuds 101", brand: "BOAT", imageName: "stundeal6", originalPrice: 17000, discountedPrice: 12999, deliveryTime: "2 HRS"),
    ShopProduct(name: "Full Sleeves Night Suit", brand: "Babyoye", imageName: "stundeal1", originalPrice: 17000, discountedPrice: 12999, deliveryTime: "2 HRS")
]
