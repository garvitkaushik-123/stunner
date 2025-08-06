//
//  MemberPage.swift
//  stunner
//
//  Created by Garvit Kaushik on 31/07/25.
//

import SwiftUI

struct MemberPage: View {
    @State private var phoneNumber: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            
            StunnerHeader()
            
            Spacer()
            
            VStack(spacing: 32) {
                
                Image("membership_card")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .cornerRadius(16)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter Phone Number")
                        .font(.visbySemibold(size: 18))
                        .foregroundColor(.gray)
                    
                    TextField("e.g. 9876543210", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .focused($isFocused)
                    
                    Button(action: {
                        // Add your submission logic here
                        print("Phone number submitted: \(phoneNumber)")
                        isFocused = false
                    }) {
                        Text("Submit")
                            .font(.visbySemibold(size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryColor)
                            .foregroundColor(.stunner)
                            .cornerRadius(12)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal)
            }
            .padding(.top, 60)
            .padding(.horizontal)
            .background(Color(.systemBackground))
            .ignoresSafeArea(edges: .bottom)
            
            Spacer()
        }
    }
}

