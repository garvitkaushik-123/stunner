import SwiftUI

struct CheckOutProduct: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let description: String
    let price: Double
}

struct CheckoutPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var CheckOutEmail: String = ""
    @State private var CheckOutPhone: String = ""
    @State private var CheckOutFirstName: String = ""
    @State private var CheckOutLastName: String = ""
    @State private var CheckOutAddress: String = ""
    @State private var CheckOutApartment: String = ""
    @State private var CheckOutCity: String = ""
    @State private var CheckOutState: String = ""
    @State private var CheckOutPinCode: String = ""
    @State private var CheckOutCountry: String = "India"
    
    let CheckOutCountries = ["India", "United States", "Canada", "Germany", "Australia"]
    
    let CheckOutProducts: [CheckOutProduct] = [
        CheckOutProduct(imageName: "product1", name: "Contrasting sheepskin", description: "Contrasting sheepskin", price: 60.00),
        CheckOutProduct(imageName: "selfcare1", name: "Kama Ayurveda", description: "Rose & Jasmine Hair Cleanser", price: 1999.99),
        CheckOutProduct(imageName: "selfcare2", name: "Clinique", description: "Clinical Serum Foundation SPF 20", price: 549.00),
        CheckOutProduct(imageName: "selfcare3", name: "Uriage", description: "Depiderm Anti-Dark Spot Skin Serum", price: 429.00)
    ]
    
    var CheckOutTotalPrice: Double {
        CheckOutProducts.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            StunnerHeader() {
                presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Items")
                        .font(.visbyBold(size: 22))
                    
                    ForEach(CheckOutProducts) { product in
                        HStack(alignment: .top, spacing: 16) {
                            Image(product.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(12)
                                .padding(4)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name)
                                    .font(.visbyBold(size: 16))
                                Text(product.description)
                                    .font(.visbyRegular(size: 14))
                                    .foregroundColor(.secondary)
                                Text("₹\(String(format: "%.2f", product.price))")
                                    .font(.visbyMedium(size: 15))
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        Divider()
                    }
                    
                    // 💵 Order Summary
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Order Summary")
                            .font(.visbyBold(size: 20))
                        Text("Total: ₹\(String(format: "%.2f", CheckOutTotalPrice))")
                            .font(.visbyMedium(size: 18))
                    }
                    
                    Divider()
                    
                    // 📧 Contact Details
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Contact Details")
                            .font(.visbyBold(size: 20))
                        TextField("Email", text: $CheckOutEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Phone Number", text: $CheckOutPhone)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                    }
                    
                    Divider()
                    
                    // 🚚 Delivery Info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Delivery Details")
                            .font(.visbyBold(size: 20))
                        
                        Picker("Country", selection: $CheckOutCountry) {
                            ForEach(CheckOutCountries, id: \.self) { country in
                                Text(country)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Group {
                            TextField("First Name", text: $CheckOutFirstName)
                            TextField("Last Name", text: $CheckOutLastName)
                            TextField("Address", text: $CheckOutAddress)
                            TextField("Apartment, Suite, etc.", text: $CheckOutApartment)
                            TextField("City", text: $CheckOutCity)
                            TextField("State", text: $CheckOutState)
                            TextField("Pin Code", text: $CheckOutPinCode)
                                .keyboardType(.numberPad)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Divider()
                    
                    // 💳 Payment Placeholder
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Payment")
                            .font(.visbyBold(size: 20))
                        Text("Payment section will go here (e.g., card info, UPI, etc.)")
                            .font(.visbyRegular(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}
