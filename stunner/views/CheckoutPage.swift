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
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                // Order Summary
                VStack(alignment: .leading, spacing: 10) {
                    Text("Order Summary")
                        .font(.headline)
                    Text("Total Price: ₹\(String(format: "%.2f", totalPrice))")
                        .font(.title3)
                }

                Divider()

                // Contact Details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contact Details")
                        .font(.headline)
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Phone Number", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                }

                Divider()

                // Delivery Details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Delivery Details")
                        .font(.headline)
                    
                    Picker("Country", selection: $country) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Address", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Apartment, Suite, etc.", text: $apartment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("City", text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("State", text: $state)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Pin Code", text: $pinCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }

                Divider()

                // Payment Section (Simple placeholder for now)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Payment")
                        .font(.headline)
                    Text("Payment section will go here (e.g., card info, UPI, etc.)")
                        .foregroundColor(.gray)
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
    }
}
