import SwiftUI

struct ShopPage: View {
    var body: some View {
        VStack(spacing: 0) {
            // STUNNER Header
            StunnerHeader()
            ScrollView {
                VStack(spacing: 32) {
                    
                    ShopProductSectionView(title: "SELF CARE", products: sampleProducts1)
                    
                    ShopProductSectionView(title: "BEST SELLERS", products: sampleProducts2)
                    
                    ShopProductSectionView(title: "STUNNER DISCOUNT DEALS", products: sampleProducts3)
                }
                .padding()
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Section View
struct ShopProductSectionView: View {
    let title: String
    let products: [ShopProduct]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .padding(.horizontal, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(products) { product in
                        ShopProductCardView(product: product)
                    }
                }
            }
        }
    }
}

// MARK: - Product Card
struct ShopProductCardView: View {
    let product: ShopProduct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 160, height: 180)
                    .clipped()
                    .cornerRadius(12)
                
                if let badge = product.deliveryTime {
                    Text(badge)
                        .font(.system(size: 10, weight: .semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                        .padding(5)
                }
            }
            
            Text(product.brand.uppercased())
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.gray)
            
            Text(product.name)
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(2)
            
            HStack(spacing: 6) {
                Text("Rs. \(product.originalPrice, specifier: "%.0f")")
                    .font(.system(size: 12))
                    .strikethrough()
                    .foregroundColor(.gray)
                
                Text("Rs. \(product.discountedPrice, specifier: "%.0f")")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        .frame(width: 160)
    }
}

// MARK: - Product Model
struct ShopProduct: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let imageName: String
    let originalPrice: Double
    let discountedPrice: Double
    let deliveryTime: String?
}

// MARK: - Sample Data
let sampleProducts1 = [
    ShopProduct(name: "Rose & Jasmine Hair Cleanser", brand: "KAMA AYURVEDA", imageName: "selfcare1", originalPrice: 699, discountedPrice: 529, deliveryTime: "60 MINS"),
    ShopProduct(name: "Clinical Serum Foundation SPF 20", brand: "Clinique", imageName: "selfcare2", originalPrice: 1999, discountedPrice: 1699, deliveryTime: "2 HRS"),
    ShopProduct(name: "Depiderm Anti-Dark Spot Skin Serum", brand: "Uriage", imageName: "selfcare3", originalPrice: 1999, discountedPrice: 1699, deliveryTime: "2 HRS"),
    ShopProduct(name: "Foaming Cleanser & Face Wash", brand: "Olay", imageName: "selfcare4", originalPrice: 1999, discountedPrice: 1699, deliveryTime: "2 HRS")
]

let sampleProducts2 = [
    ShopProduct(name: "Full Sleeves Night Suit", brand: "Babyoye", imageName: "stundeal1", originalPrice: 12999, discountedPrice: 11099, deliveryTime: "60 MINS"),
    ShopProduct(name: "ARKS Baseball cap", brand: "ARKS", imageName: "stundeal2", originalPrice: 12999, discountedPrice: 11099, deliveryTime: "60 MINS"),
    ShopProduct(name: "Stanley Quencher", brand: "Stanley", imageName: "stundeal4", originalPrice: 12999, discountedPrice: 11099, deliveryTime: "60 MINS"),
    ShopProduct(name: "CHAPTER 2 BLACK JACKET", brand: "CHAPTER 2", imageName: "stundeal3", originalPrice: 5490, discountedPrice: 5050, deliveryTime: "60 MINS")
]

let sampleProducts3 = [
    ShopProduct(name: "TOM FORD BOIS PARFUM", brand: "TOM FORD", imageName: "product1", originalPrice: 17000, discountedPrice: 12999, deliveryTime: "2 HRS"),
    ShopProduct(name: "Earbuds 101", brand: "BOAT", imageName: "stundeal6", originalPrice: 17000, discountedPrice: 12999, deliveryTime: "2 HRS"),
    ShopProduct(name: "Full Sleeves Night Suit", brand: "Babyoye", imageName: "stundeal1", originalPrice: 17000, discountedPrice: 12999, deliveryTime: "2 HRS"),
]

