import SwiftUI

// MARK: - Model
struct BrandProduct: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let price: String
    let originalPrice: String
    let discount: String
}

struct BrandProductCard: View {
    let product: BrandProduct

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()

                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(16)
            }

            VStack(spacing: 4) {
                Text(product.name.uppercased())
                    .font(.visbyMedium(size: 11))
                    .tracking(0.08 * 11)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 8) {
                    Text(product.price)
                        .font(.visbyMedium(size: 9))
                        .tracking(0.03 * 11)

                    Text(product.originalPrice)
                        .font(.visbyMedium(size: 9))
                        .tracking(0.03 * 11)
                        .strikethrough()
                        .foregroundColor(Color(hex: "b0b0b0"))

                    Text(product.discount)
                        .font(.visbyMedium(size: 9))
                        .tracking(0.03 * 11)
                }
            }
        }
    }
}

struct BrandHeaderBar: View {
    var body: some View {
        HStack {
            // Brand Name
            Text("MIRAGGIO")
                .font(.visbyBold(size: 20))
                .foregroundColor(.black)

            // Follow Button
            Button(action: {
                // Add your follow action here
            }) {
                Text("FOLLOW")
                    .font(.visbySemibold(size: 10))
                    .tracking(0.05 * 10)
                    .foregroundColor(Color.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.gray.opacity(0.2))
                    .multilineTextAlignment(.center)
            }
            Spacer()
            // Item Count
            Text("23 ITEM(s)")
                .font(.visbyMedium(size: 9))
                .tracking(0.03 * 9)
                .foregroundColor(.black)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    BrandHeaderBar()
}

#Preview {
    BrandProductCard(product: BrandProduct(
        imageName: "martina", // Make sure this image exists in Assets.xcassets
        name: "Martina Tote Bag",
        price: "₹2,399",
        originalPrice: "₹5,499",
        discount: "20% OFF"
    ))
}


// MARK: - Main View
struct BrandPage: View {
    @Environment(\.presentationMode) var presentationMode

    let products = [
        BrandProduct(imageName: "hazelnut", name: "HAZELNUT BAG", price: "₹4,499", originalPrice: "₹4,999", discount: "10% OFF"),
        BrandProduct(imageName: "martina", name: "BLAIR HANDBAG", price: "₹3,149", originalPrice: "₹4,499", discount: "30% OFF"),
        BrandProduct(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        BrandProduct(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        BrandProduct(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        BrandProduct(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        BrandProduct(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        BrandProduct(imageName: "callie", name: "CALLIE SATCHEL BAG", price: "₹3,299", originalPrice: "₹5,999", discount: "45% OFF"),
        BrandProduct(imageName: "river", name: "RIVER SATCHEL BAG", price: "₹1,799", originalPrice: "₹4,499", discount: "60% OFF")
    ]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 0)
    ]
    var body: some View {
        VStack(spacing: 0) {
            StunnerHeader(showBackButton: true) {
                presentationMode.wrappedValue.dismiss()
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    BrandHeaderBar()

                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(products) { product in
                            BrandProductCard(product: product)
                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
        .background(Color.stunner)
        .navigationBarHidden(true)
    }
}

struct BrandPage_Previews: PreviewProvider {
    static var previews: some View {
        BrandPage()
    }
}


//import SwiftUI
//import Foundation
//
//struct ProductItem: Identifiable {
//    let id = UUID()
//    let imageName: String
//    let title: String
//    let price: Int
//    let originalPrice: Int
//}
//
//let productData: [ProductItem] = [
//    ProductItem(imageName: "martina", title: "MARTINA TOTE BAG", price: 2399, originalPrice: 2999)
////    ProductItem(imageName: "destiny1", title: "DESTINY TOTE BAG", price: 3599, originalPrice: 4499)
////    ProductItem(imageName: "amalfi", title: "AMALFI SHOULDER BAG", price: 2399, originalPrice: 2999),
////    ProductItem(imageName: "ray", title: "RAY CROSSBODY BAG", price: 2799, originalPrice: 3499),
////    ProductItem(imageName: "marina", title: "MARINA TRAVEL POUCH", price: 2399, originalPrice: 2999),
////    ProductItem(imageName: "destiny2", title: "DESTINY TOTE BAG", price: 2399, originalPrice: 2999),
////    ProductItem(imageName: "amalfi_red", title: "AMALFI SHOULDER BAG", price: 2399, originalPrice: 2999),
////    ProductItem(imageName: "seashore", title: "SEA SHORE CHARM", price: 2399, originalPrice: 2999)
//]
//
//struct BrandPage: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    let brandName: String
//    
//    init(brandName: String = "MIRAGGIO") {
//        self.brandName = brandName
//    }
//    
//    let columns = [
//        GridItem(.flexible(), spacing: 16),
//        GridItem(.flexible(), spacing: 16)
//    ]
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            StunnerHeader(showBackButton: true) {
//                presentationMode.wrappedValue.dismiss()
//            }
//            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    HStack {
//                        Text(brandName)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                        
//                        Button(action: {}) {
//                            Text("FOLLOW")
//                                .font(.caption)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 4)
//                                .background(Color(hex: "#E9E9E9"))
//                                .cornerRadius(4)
//                        }
//                        
//                        Spacer()
//                        
//                        Text("23 ITEM(s)")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.horizontal)
//                    
//                    // Items Grid
//                    LazyVGrid(columns: columns, spacing: 24) {
//                        ForEach(productData, id: \.id) { item in
//                            VStack(spacing: 8) {
//                                Image(item.imageName)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(height: 130)
//                                    .background(Color.white)
//                                
//                                Text(item.title)
//                                    .font(.footnote)
//                                    .foregroundColor(.black)
//                                
//                                HStack(spacing: 4) {
//                                    Text("₹\(item.price)")
//                                        .font(.footnote)
//                                        .fontWeight(.semibold)
//                                    
//                                    Text("₹\(item.originalPrice)")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//                                        .strikethrough()
//                                    
//                                    Text("20% OFF")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                            .padding()
//                            .background(Color(hex: "#FFFFFF"))
//                            .cornerRadius(10)
//                            .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            }
//        }
//        .background(Color(hex: "#E9E9E9"))
//    }
//}
//
//// Preview
////struct BrandPage_Previews: PreviewProvider {
////    static var previews: some View {
////        BrandPage()
////    }
////}
