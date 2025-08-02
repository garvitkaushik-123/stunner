import SwiftUI
import SwiftUI

struct CartPage: View {
    @ObservedObject var viewModel = CartViewModel()
    @State private var showingCheckout = false
    @State private var agreedToTerms = false
    @GestureState private var dragOffset = CGSize.zero
    
    let cartItems = [
        CartItem(name: "Contrasting sheepskin", price: 60.00, imageName: "product1"),
        CartItem(name: "Clinique", price: 1999.99, imageName: "selfcare2"),
        CartItem(name: "KAMA AYURVEDA", price: 549.00, imageName: "selfcare1"),
        CartItem(name: "Uriage", price: 429.00, imageName: "selfcare3")
    ]
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // STUNNER Header
                    StunnerHeader()
                    
                    // Cart Items List
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(cartItems, id: \.id) { item in
                                CartItemRow(item: item)
                                
                                if item.id != cartItems.last?.id {
                                    Divider()
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                        .padding(.horizontal, 20)
                    }
                    
                    // Footer Section
                    VStack(spacing: 20) {
                        // Subtotal
                        HStack {
                            Text("Subtotal")
                                .font(.visbyBold(size: 18))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("Rs.\(String(format: "%.0f", subtotal))")
                                .font(.visbyBold(size: 18))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        
                        // Terms & Conditions
                        HStack(alignment: .top, spacing: 12) {
                            Button(action: {
                                agreedToTerms.toggle()
                            }) {
                                Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                                    .font(.system(size: 20))
                                    .foregroundColor(agreedToTerms ? .blue : .gray)
                            }
                            
                            HStack(spacing: 4) {
                                Text("I AGREE WITH")
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                
                                if #available(iOS 16.0, *) {
                                    Button("TERMS & CONDITIONS") {
                                        
                                    }
                                    .font(.visbyMedium(size: 14))
                                    .foregroundColor(.blue)
                                    .underline()
                                } else {
                                    // Fallback on earlier versions
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        // Checkout Button
                        Button(action: {
                            if agreedToTerms {
                                showingCheckout = true
                            }
                        }) {
                            Text("Check Out Now")
                                .font(.visbyMedium(size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(agreedToTerms ? Color.black : Color.gray)
                                .cornerRadius(8)
                        }
                        .disabled(!agreedToTerms)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
                .offset(x: dragOffset.width, y: 0)
                .animation(.interactiveSpring(), value: dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if value.startLocation.x < 50 && value.translation.width > 0 {
                                state = value.translation
                            }
                        }
                        .onEnded { value in
                            if value.translation.width > 100 {
                                withAnimation {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                )
            }
        }
        .navigationBarHidden(true)
        .background(
            NavigationLink(destination: CheckoutPage(), isActive: $showingCheckout) {
                EmptyView()
            }.hidden()
        )
    }
    
    @Environment(\.presentationMode) var presentationMode
}

// Cart Item Row Component
struct CartItemRow: View {
    let item: CartItem
    @State private var quantity = 1
    
    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
            
            // Product Details
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.visbyBold(size: 16))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("Foris Large Piped Velvet Cushion")
                    .font(.visbyRegular(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text("XL/Blue")
                    .font(.visbyRegular(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Quantity and Price
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(quantity) X Rs.\(String(format: "%.0f", item.price))")
                    .font(.visbyMedium(size: 14))
                    .foregroundColor(.primary)
                
                // Remove Button
                Button(action: {
                    // TODO: Remove item from cart
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.red)
                        .frame(width: 20, height: 20)
                        .background(Color.red.opacity(0.1))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

// Preview
struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}
