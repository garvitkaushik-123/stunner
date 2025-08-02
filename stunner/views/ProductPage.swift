import SwiftUI

struct SwipeToBuyButton: View {
    var action: () -> Void
    @State private var offsetX: CGFloat = 0
    @State private var isComplete = false
    let circleSize: CGFloat = 44
    let padding: CGFloat = 4

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let dragLimit = totalWidth - circleSize - padding * 2

            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(isComplete ? Color.green : Color.black)
                    .frame(height: 50)
                    .overlay(
                        Text(isComplete ? "BOUGHT" : "SWIPE TO BUY")
                            .font(.visbyMedium(size: 16))
                            .foregroundColor(.white)
                    )
                
                HStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: circleSize, height: circleSize)
                        .overlay(
                            Image(systemName: isComplete ? "checkmark" : "chevron.right")
                                .foregroundColor(isComplete ? .green : .black)
                                .font(.system(size: 22, weight: .bold))
                        )
                        .offset(x: offsetX)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if !isComplete {
                                        offsetX = max(0, min(value.translation.width, dragLimit))
                                    }
                                }
                                .onEnded { _ in
                                    if offsetX >= dragLimit {
                                        withAnimation(.spring()) {
                                            offsetX = dragLimit
                                            isComplete = true
                                        }
                                        action()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                            withAnimation {
                                                offsetX = 0
                                                isComplete = false
                                            }
                                        }
                                    } else {
                                        withAnimation {
                                            offsetX = 0
                                        }
                                    }
                                }
                        )
                    Spacer()
                }
                .padding(.leading, padding)
            }
            .frame(height: 50)
        }
        .frame(height: 50)
        .padding(.horizontal, 16)
    }
}

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
    
    // Horizontal padding constant for consistent margins
    private let horizontalPadding: CGFloat = 16
    
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
                                        selectedImageIndex = index
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: 60, height: 60)
                                            
                                            Image(productImages[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 60, height: 60)
                                                .clipped()
                                                .cornerRadius(8)
                                        }
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(selectedImageIndex == index ? Color.black : Color.clear, lineWidth: 2)
                                        )
                                        .scaleEffect(selectedImageIndex == index ? 1.05 : 1.0)
                                        .animation(.easeInOut(duration: 0.2), value: selectedImageIndex)
                                    }
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
                                .frame(width: UIScreen.main.bounds.width - 140, height: 380)
                                .clipped()
                                .cornerRadius(12)
                        }
                        .padding(.trailing, horizontalPadding)
                        
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
                            .padding(.horizontal, horizontalPadding)
                        
                        // Stock Status
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                            Text("In Stock")
                                .font(.visbyMedium(size: 14))
                                .foregroundColor(.green)
                        }
                        .padding(.horizontal, horizontalPadding)
                        
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
                        .padding(.horizontal, horizontalPadding)
                        
                        // Payment Option
                        HStack {
                            Text("or Pay ₹800 now & rest later via Miraggio Pay Later")
                                .font(.visbyRegular(size: 14))
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "info.circle")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, horizontalPadding)
                        
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
                                                    .stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, horizontalPadding)
                        
                        // Delivery Check
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                TextField("Enter your pincode", text: $pincode)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.visbyRegular(size: 16))
                                    .keyboardType(.numberPad)
                                    .frame(maxWidth: .infinity)
                                
                                Button("CHECK") {
                                    // TODO: Implement pincode check
                                }
                                .font(.visbyMedium(size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.black)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, horizontalPadding)
                        
                        // New Button Layout - Plus and Swipe to Buy
                        HStack(spacing: 16) {
                            // Plus Button
                            
                            
                            Button(action: {
                                navigateToCart = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                    .background(Color.black)
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                            
                            // Swipe to Buy Button
                            SwipeToBuyButton {
                                print("buy")
                            }
                            
                        }
                        .padding(.horizontal, horizontalPadding)
                        
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
                        .padding(.horizontal, horizontalPadding)
                        
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
                            .padding(.horizontal, horizontalPadding)
                            
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
                            .padding(.horizontal, horizontalPadding)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
