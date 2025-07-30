import SwiftUI

struct ProductCardView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)

            Text(product.name)
                .font(.headline)

            Text("₹\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
