import SwiftUI

struct BrandPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    struct Product: Identifiable {
        let id = UUID()
        let imageName: String
        let name: String
        let price: String
        let originalPrice: String
        let discount: String
    }
    
    let products = [
        Product(imageName: "hazelnut", name: "HAZELNUT BAG", price: "₹4,499", originalPrice: "₹4,999", discount: "10% OFF"),
        Product(imageName: "martina", name: "BLAIR HANDBAG", price: "₹3,149", originalPrice: "₹4,499", discount: "30% OFF"),
        Product(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        Product(imageName: "river", name: "RIVER SATCHEL BAG", price: "₹1,799", originalPrice: "₹4,499", discount: "60% OFF")
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            StunnerHeader(showBackButton: true) {
                presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Top-left brand title
                Text("Miraggio")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top, 16)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products) { product in
                        VStack(spacing: 8) {
                            // Image
                            Image(product.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 160)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            
                            // Name
                            Text(product.name)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity)
                            
                            // Price section
                            HStack(spacing: 6) {
                                Text(product.price)
                                    .font(.subheadline)
                                Text(product.discount)
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        }
        .background(Color.white)
        .navigationBarHidden(true)

    }
}
