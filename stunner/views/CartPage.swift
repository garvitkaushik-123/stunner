import SwiftUI

struct CartPage: View {
    @StateObject private var viewModel = CartViewModel()
    @State private var showingCheckout = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            Text("Shopping Cart")
                .font(.visbyBold(size: 28))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
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
                                    .font(.visbyMedium(size: 18))
                                
                                Text("₹\(String(format: "%.2f", item.price))")
                                    .font(.visbyRegular(size: 16))
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
