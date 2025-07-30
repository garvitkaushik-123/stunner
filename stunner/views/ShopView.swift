import SwiftUI

struct ShopView: View {
    let verticalProducts = Product.sampleProducts
    let horizontalProducts = Product.sampleProducts.shuffled()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<verticalProducts.count, id: \.self) { index in
                    // 👉 Full-width vertical product card
                    ProductCardView(product: verticalProducts[index])
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)

                    // 👉 Insert horizontal row after every 2 vertical products
                    if (index + 1) % 2 == 0 {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(horizontalProducts) { product in
                                    HorizontalProductCardView(product: product)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 220)
                    }
                }
            }
            .padding(.top)
        }
    }
}
