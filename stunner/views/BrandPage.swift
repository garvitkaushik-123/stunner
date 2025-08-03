import SwiftUI
import Foundation

struct ProductItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let price: Int
    let originalPrice: Int
}

let productData: [ProductItem] = [
    ProductItem(imageName: "martina", title: "MARTINA TOTE BAG", price: 2399, originalPrice: 2999),
    ProductItem(imageName: "destiny1", title: "DESTINY TOTE BAG", price: 3599, originalPrice: 4499),
    ProductItem(imageName: "amalfi", title: "AMALFI SHOULDER BAG", price: 2399, originalPrice: 2999),
    ProductItem(imageName: "ray", title: "RAY CROSSBODY BAG", price: 2799, originalPrice: 3499),
    ProductItem(imageName: "marina", title: "MARINA TRAVEL POUCH", price: 2399, originalPrice: 2999),
    ProductItem(imageName: "destiny2", title: "DESTINY TOTE BAG", price: 2399, originalPrice: 2999),
    ProductItem(imageName: "amalfi_red", title: "AMALFI SHOULDER BAG", price: 2399, originalPrice: 2999),
    ProductItem(imageName: "seashore", title: "SEA SHORE CHARM", price: 2399, originalPrice: 2999)
]

struct BrandPage: View {
    @Environment(\.presentationMode) var presentationMode

    let brandName: String
    
    init(brandName: String = "MIRAGGIO") {
        self.brandName = brandName
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            StunnerHeader(showBackButton: true) {
                presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(brandName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Button(action: {}) {
                            Text("FOLLOW")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(hex: "#E9E9E9"))
                                .cornerRadius(4)
                        }
                        
                        Spacer()
                        
                        Text("23 ITEM(s)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    // Items Grid
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(productData, id: \.id) { item in
                            VStack(spacing: 8) {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 130)
                                    .background(Color.white)
                                
                                Text(item.title)
                                    .font(.footnote)
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 4) {
                                    Text("₹\(item.price)")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Text("₹\(item.originalPrice)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                    
                                    Text("20% OFF")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(hex: "#FFFFFF"))
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(Color(hex: "#E9E9E9"))
    }
}

// Preview
//struct BrandPage_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandPage()
//    }
//}
