import SwiftUI

struct ProductPage: View {
    let productImages = [
        "lady", "bag1", "bag2", "bag3", "bag4"
    ]
    
    @State private var navigateToCart = false
    @State private var selectedImageIndex = 0
    @State private var selectedColor = "Green"
    @State private var pincode = ""
    @State private var isDescriptionExpanded = false
    @State private var isShippingExpanded = false
    @State private var isMoreInfoExpanded = false
    
    let colors = ["Green", "Beige"]
    let originalPrice = 2999.0
    let currentPrice = 2399.0
    let discountPercentage = 20
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Product Image Gallery and Details Section
                HStack(alignment: .top, spacing: 0) {
                    // Left Section - Product Image Gallery
                    VStack(spacing: 16) {
                        // Thumbnail Images
                        VStack(spacing: 8) {
                            ForEach(0..<min(6, productImages.count), id: \.self) { index in
                                Button(action: {
                                    print("Thumbnail tapped: \(index), image: \(productImages[index])")
                                    selectedImageIndex = index
                                    print("Selected image index updated to: \(selectedImageIndex)")
                                }) {
                                    ZStack {
                                        // Background color in case image fails to load
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 60, height: 60)
                                        
                                        // Image with error handling
                                        Image(productImages[index])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipped()
                                            .cornerRadius(8)
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedImageIndex == index ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                                    .scaleEffect(selectedImageIndex == index ? 1.05 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: selectedImageIndex)
                                }
                                .highPriorityGesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("High priority tap detected on thumbnail: \(index)")
                                            selectedImageIndex = index
                                        }
                                )
                            }
                        }
                        .padding(.leading, 24)
                        
                        Spacer()
                    }
                    .frame(width: 100)
                    
                    // Main Product Image
                    ZStack {
                        // Background color in case image fails to load
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 280, height: 380)
                        
                        Image(productImages[selectedImageIndex])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 380)
                            .clipped()
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                }
                .padding(.vertical, 24)
                
                // Right Section - Product Details
                VStack(alignment: .leading, spacing: 24) {
                    // Product Name
                    Text("SOLEIL CROSSBODY BAG")
                        .font(.visbyBold(size: 24))
                        .foregroundColor(.primary)
                        .textCase(.uppercase)
                    
                    // Stock Status
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                        Text("In Stock")
                            .font(.visbyMedium(size: 14))
                            .foregroundColor(.green)
                    }
                    
                    // Pricing
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("₹\(String(format: "%.0f", currentPrice))")
                                .font(.visbyBold(size: 28))
                                .foregroundColor(.primary)
                            
                            Text("₹\(String(format: "%.0f", originalPrice))")
                                .font(.visbyRegular(size: 18))
                                .foregroundColor(.secondary)
                                .strikethrough()
                            
                            Text("\(discountPercentage)% OFF")
                                .font(.visbyMedium(size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                        
                        Text("(Inclusive of all taxes)")
                            .font(.visbyLight(size: 12))
                            .foregroundColor(.secondary)
                    }
                    
                    // Payment Option
                    HStack {
                        Text("or Pay ₹800 now & rest later via Miraggio Pay Later")
                            .font(.visbyRegular(size: 14))
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "info.circle")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                    
                    // Color Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Color: \(selectedColor)")
                            .font(.visbyMedium(size: 16))
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 16) {
                            ForEach(colors, id: \.self) { color in
                                Button(action: {
                                    selectedColor = color
                                }) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(color == "Green" ? Color.green : Color(red: 0.9, green: 0.8, blue: 0.7))
                                        .frame(width: 36, height: 36)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(selectedColor == color ? Color.blue : Color.clear, lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                    
                    // Delivery Check
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            TextField("Enter your pincode", text: $pincode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.visbyRegular(size: 16))
                                .keyboardType(.numberPad)
                            
                            Button("CHECK") {
                                // TODO: Implement pincode check
                            }
                            .font(.visbyMedium(size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                    }
                    
                    // Add to Cart Button
                    Button(action: {
                        navigateToCart = true
                    }) {
                        HStack {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                            Text("ADD TO CART")
                                .font(.visbyMedium(size: 16))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    
                    // Offers
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Offers")
                            .font(.visbyBold(size: 16))
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("Get ₹200 off on orders above ₹3999. Use code: TREAT")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("Additional 5% off up to ₹100 on all prepaid orders")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    // Collapsible Sections
                    VStack(spacing: 0) {
                        // Description
                        CollapsibleSection(
                            title: "Description",
                            isExpanded: $isDescriptionExpanded
                        ) {
                            Text("The Soleil Crossbody Bag features a modern design with vertical stripes, premium leather strap, and the iconic Miraggio logo. Perfect for everyday use with ample storage space and comfortable crossbody wear.")
                                .font(.visbyRegular(size: 14))
                                .foregroundColor(.secondary)
                                .padding(.top, 12)
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        // Shipping & Returns
                        CollapsibleSection(
                            title: "Shipping & Returns",
                            isExpanded: $isShippingExpanded
                        ) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("• Free shipping on orders above ₹999")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("• 30-day return policy")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("• Express delivery available")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 12)
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        // More Information
                        CollapsibleSection(
                            title: "More Information",
                            isExpanded: $isMoreInfoExpanded
                        ) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Material: Premium leather and canvas")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("Dimensions: 25cm x 15cm x 8cm")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("Weight: 450g")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 12)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .onTapGesture {
            print("HI")
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(
            NavigationLink(destination: CartPage(), isActive: $navigateToCart) {
                EmptyView()
            }.hidden()
        )
        .onAppear {
            print("ProductPage appeared with \(productImages.count) images")
            print("Available images: \(productImages)")
        }
    }
}

// Collapsible Section Component
struct CollapsibleSection<Content: View>: View {
    let title: String
    @Binding var isExpanded: Bool
    let content: Content
    
    init(title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.visbyMedium(size: 16))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 16)
            }
            
            if isExpanded {
                content
                    .padding(.bottom, 16)
            }
        }
    }
}
