import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Subtotal & Buy Button
            VStack(alignment: .leading, spacing: 12) {
                Text("Subtotal (\(viewModel.cartItems.count) items): ₹\(String(format: "%.2f", viewModel.subtotal))")
                    .font(.title3)
                    .bold()
                
                Button(action: {
                    print("Proceed to buy tapped")
                }) {
                    Text("Proceed to Buy")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .shadow(radius: 1)
            
            // Cart List
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.cartItems) { item in
                        HStack(spacing: 16) {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text("₹\(String(format: "%.2f", item.price))")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 1)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
