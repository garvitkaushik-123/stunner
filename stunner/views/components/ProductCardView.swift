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
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.visbyMedium(size: 16))
                    .foregroundColor(.primary)
                
                Text("₹\(String(format: "%.2f", product.price))")
                    .font(.visbyRegular(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
    }
}
