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
                VStack(alignment: .leading, spacing: 60) {
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
        VStack(alignment: .leading) {
            Text(title)
                .font(.visbyMedium(size: 15))
                .tracking(0.08 * 15)
                .background(Color.stunner)
            Spacer().frame(height: 20)
            LazyVGrid(columns: columns) {
                ForEach(products) { product in
                    ShopProductCard(product: product)
                }
            }.background(Color.stunner)
        }.background(Color.stunner)
    }
}

// MARK: - Card (Similar to BrandProductCard)
struct ShopProductCard: View {
    let product: ShopProduct

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topLeading) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()

                if let deliveryTime = product.deliveryTime {
                    Text(deliveryTime)
                        .font(.visbyMedium(size: 9))
                        .foregroundColor(Color.originalPrice)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .padding(8)
                }

                // Move the plus icon to bottomTrailing inside a nested ZStack
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .padding(16)
                    }
                }
            }

            VStack(spacing: 6) {
                // Brand name
                Text(product.brand.uppercased())
                    .font(.visbyMedium(size: 12))
                    .tracking(0.08 * 10)
                    .multilineTextAlignment(.center)

                // Product name
                Text(product.name)
                    .font(.visbyRegular(size: 8))
                    .tracking(0.03 * 8)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.discover)

                // Price + discount
                HStack(spacing: 6) {
                    Text("₹\(Int(product.discountedPrice))")
                        .font(.visbyMedium(size: 9))

                    Text("₹\(Int(product.originalPrice))")
                        .font(.visbyRegular(size: 9))
                        .strikethrough()
                        .foregroundColor(Color.discover)

                    let discount = Int(100 - (product.discountedPrice / product.originalPrice) * 100)
                    
                    Text("\(discount)% OFF")
                        .font(.visbyMedium(size: 9))
                        .tracking(0.03 * 9)
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
    ShopProduct(name: "Rose & Jasmine Cleanser", brand: "KAMA AYURVEDA", imageName: "selfcare1", originalPrice: 699, discountedPrice: 529, deliveryTime: "60 MINS"),
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
