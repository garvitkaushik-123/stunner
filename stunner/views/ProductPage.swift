import SwiftUI

struct ProductPage: View {
    let images = [
        "product7", "product1", "product6"
    ]
    
    @State private var navigateToCart = false
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: CartPage(), isActive: $navigateToCart) {
                EmptyView()
            }.hidden()
            
            VStack(alignment: .leading, spacing: 16) {
                // 1. Image Carousel
                TabView {
                    ForEach(images, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                
                // 2. Product Details
                VStack(alignment: .leading, spacing: 8) {
                    Text("Awesome Product Title")
                        .font(.dmSans(size: 20))
                        .foregroundColor(.primaryColor)
                        .textCase(.uppercase)
                    
                    Text("₹1,299")
                        .font(.dmSans(size: 24))
                        .foregroundColor(.critical)
                    
                    Button(action: {
                        navigateToCart = true
                    }) {
                        Text("ADD TO CART")
                            .font(.dmSans(size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                // 3. Horizontal Grid Additional Photos
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(images, id: \.self) { name in
                            Image(name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        }
                    }.padding(.horizontal)
                }
                
                // 4. Reviews Section (static samples)
                VStack(alignment: .leading, spacing: 8) {
                    Text("User Reviews")
                        .font(.dmSans(size: 18))
                        .foregroundColor(.main)
                    
                    ForEach(0..<3) { _ in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("★ ★ ★ ★ ☆")
                                .font(.dmSans(size: 16))
                            Text("“This product is really nice, good quality!”")
                                .font(.dmSans(size: 14))
                                .foregroundColor(.secondary2)
                        }
                        .padding(.vertical, 8)
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
