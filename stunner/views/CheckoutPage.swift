import SwiftUI

struct CheckoutPage: View {
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var address: String = ""
    @State private var apartment: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var pinCode: String = ""
    @State private var country: String = "India"
    @State private var totalPrice: Double = 1999.99

    let countries = ["India", "United States", "Canada", "Germany", "Australia"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Stunner")
                    .font(.visbyExtrabold(size: 32))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                // Order Summary
                VStack(alignment: .leading, spacing: 10) {
                    Text("Order Summary")
                        .font(.visbyBold(size: 20))
                    Text("Total Price: ₹\(String(format: "%.2f", totalPrice))")
                        .font(.visbyMedium(size: 18))
                }

                Divider()

                // Contact Details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contact Details")
                        .font(.visbyBold(size: 20))
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("Phone Number", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                        .font(.visbyRegular(size: 16))
                }

                Divider()

                // Delivery Details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Delivery Details")
                        .font(.visbyBold(size: 20))
                    
                    Picker("Country", selection: $country) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                                .font(.visbyRegular(size: 16))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("Address", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("Apartment, Suite, etc.", text: $apartment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("City", text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("State", text: $state)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.visbyRegular(size: 16))
                    TextField("Pin Code", text: $pinCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .font(.visbyRegular(size: 16))
                }

                Divider()

                // Payment Section (Simple placeholder for now)
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
        .navigationBarTitle("Checkout", displayMode: .inline)
    }
}
