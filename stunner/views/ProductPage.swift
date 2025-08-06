import SwiftUI

struct ProductPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    let productImages = [
        "bag1", "lady" , "bag2", "bag3"
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
    
    // Horizontal padding constant for consistent margins
    private let horizontalPadding: CGFloat = 16
    
    var body: some View {
        VStack(spacing: 0) {
            StunnerHeader(showBackButton: true) {
                presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    // Product Image Gallery and Details Section
                    ZStack {
                        // Main content layer (z-index: 0)
                        HStack(alignment: .top, spacing: 0) {
                            // Left Section - Product Image Gallery (placeholder for spacing)
                            VStack(spacing: 16) {
                                // Thumbnail Images placeholder
                                VStack(spacing: 8) {
                                    ForEach(0..<min(6, productImages.count), id: \.self) { index in
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.clear)
                                            .frame(width: 60, height: 90)
                                    }
                                }
                                .padding(.leading, horizontalPadding)
                                
                                Spacer()
                            }
                            .frame(width: 80)
                            
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: UIScreen.main.bounds.width - 140, height: 380) // Dynamic width
                                
                                Image(productImages[selectedImageIndex])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 140, height: 384)
                                    .clipped()
                            }
                            .padding(.trailing, horizontalPadding)
                            
                            Spacer()
                        }
                        
                        // Thumbnail images layer (z-index: 1)
                        HStack(alignment: .top, spacing: 0) {
                            VStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    ForEach(0..<min(6, productImages.count), id: \.self) { index in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 0)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: 60, height: 90)
                                            
                                            Image(productImages[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 60, height: 90)
                                                .clipped()
                                        }
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 0)
                                                .stroke(selectedImageIndex == index ? Color.black : Color.clear, lineWidth: 2)
                                        )
                                        .scaleEffect(selectedImageIndex == index ? 1.05 : 1.0)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                selectedImageIndex = index
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, horizontalPadding)
                                
                                Spacer()
                            }
                            .frame(width: 80)
                            
                            Spacer()
                            
                            // Empty space to maintain layout
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width - 140)
                            
                            Spacer()
                        }
                        .zIndex(1)
                    }
                    .padding(.vertical, 24)
                    
                    // Right Section - Product Details
                    VStack(alignment: .leading, spacing: 16) {
                        // Product Name
                        Text("SOLEIL CROSSBODY BAG")
                            .font(.visbyMedium(size: 20))
                            .foregroundColor(Color.product)
                            .tracking(20.0 * 0.08)
                            .textCase(.uppercase)
                            .padding(.horizontal, horizontalPadding)
                        
                        // Star Rating
                        HStack(spacing: 0) {
                            ForEach(0..<4) { _ in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.black)
                                Spacer().frame(width: 6)
                            }
                        }
                        .padding(.horizontal, horizontalPadding)

                        Spacer().frame(height: 5)
                        
                        // Pricing Style from Figma
                        HStack(spacing: 8) {
                            Text("₹\(String(format: "%.0f", originalPrice))")
                                .font(.visbyMedium(size: 12))
                                .foregroundColor(Color.originalPrice)
                                .strikethrough()
                            
                            Image(systemName: "tag.fill")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.black)
                            
                            Text("INR 2,399")
                                .font(.visbySemibold(size: 18))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, horizontalPadding)
                        
                        // New Button Layout - Plus and Swipe to Buy
                        HStack(spacing: 16) {
                            // Swipe to Buy Button
                            SwipeToBuyButton {
                                navigateToCart = true
                            }
                            
                        }
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 15)
                        
                        // Mood Text (Replacing Offers Section)
                        Text("Sun-chaser. Light packer. All-round vibe curator. Soleil is the friend you call when the city feels loud and the ocean is calling.")
                            .font(.visbyMedium(size: 11))
                            .tracking(0.02 * 11)
                            .foregroundColor(Color.discover)
                            .lineSpacing(6)
                            .padding(.horizontal, 30)
                            .padding(.top, 15)
                        
                        VStack(spacing: 0) {
                            // Description
                            CollapsibleSection(
                                title: "Description",
                                isExpanded: $isDescriptionExpanded
                            ) {
                                Text("The Soleil Crossbody Bag features a modern design with vertical stripes, premium leather strap, and the iconic Miraggio logo. Perfect for everyday use with ample storage space and comfortable crossbody wear.")
                                    .font(.visbyMedium(size: 11))
                                    .tracking(0.02 * 11)
                                    .foregroundColor(Color.discover)
                                    .padding(.top, 12)
                            }
                            .padding(.horizontal, horizontalPadding)
                            .padding(.top, 15)
                            
                            Divider()
                                .padding(.vertical, 8)
                                .padding(.horizontal, horizontalPadding)
                            
                            // Shipping & Returns
                            CollapsibleSection(
                                title: "Shipping & Returns",
                                isExpanded: $isShippingExpanded
                            ) {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("• Free shipping on orders above ₹999")
                                        .font(.visbyMedium(size: 11))
                                        .tracking(0.02 * 11)
                                        .foregroundColor(Color.discover)
                                    Text("• 30-day return policy")
                                        .font(.visbyMedium(size: 11))
                                        .tracking(0.02 * 11)
                                        .foregroundColor(Color.discover)
                                    Text("• Express delivery available")
                                        .font(.visbyMedium(size: 11))
                                        .tracking(0.02 * 11)
                                        .foregroundColor(Color.discover)
                                }
                                .padding(.top, 12)
                            }
                            .padding(.horizontal, horizontalPadding)
                            
                            Divider()
                                .padding(.vertical, 8)
                                .padding(.horizontal, horizontalPadding)
                            
                            // More Information
                            CollapsibleSection(
                                title: "More Information",
                                isExpanded: $isMoreInfoExpanded
                            ) {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Material: Premium leather and canvas")
                                        .font(.visbyMedium(size: 11))
                                        .tracking(0.02 * 11)
                                        .foregroundColor(Color.discover)
                                    Text("Dimensions: 25cm x 15cm x 8cm")
                                        .font(.visbyMedium(size: 11))
                                        .tracking(0.02 * 11)
                                        .foregroundColor(Color.discover)
                                    Text("Weight: 450g")
                                        .font(.visbyMedium(size: 11))
                                        .tracking(0.02 * 11)
                                        .foregroundColor(Color.discover)
                                }
                                .padding(.top, 12)
                            }
                            .padding(.horizontal, horizontalPadding)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(destination: CartPage(), isActive: $navigateToCart) {
                    EmptyView()
                }.hidden()
            )
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
}

struct ProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductPage()
    }
}
