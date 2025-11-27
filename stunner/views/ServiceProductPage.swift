import SwiftUI
import UIKit

struct ServiceProductPage: View {
    private let heroImagePath = "/mnt/data/IMG_5862E9A7F324-1.jpeg"

    var body: some View {
        VStack(spacing: 0) {
            
            StunnerHeader()
            
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        
                        HeroSection(imagePath: heroImagePath)
                        
                        VStack(spacing: 0) {
                            ServiceRow(
                                avatarName: "avatar1",
                                title: "Luxe",
                                tag: "LUXURY",
                                brands: ["AINHOA", "CASMARA", "CIREPIL"]
                            )
                            
                            Divider().padding(.vertical, 24)
                            
                            ServiceRow(
                                avatarName: "avatar2",
                                title: "Prime",
                                tag: "PREMIUM",
                                brands: ["O3+", "RICA", "INVEDA"]
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .navigationBarHidden(true)
            }
        }
        .navigationBarHidden(true)
        .statusBarHidden(true)
    }
}

struct HeroSection: View {
    let imagePath: String

    private func loadUIImage() -> UIImage {
        UIImage(contentsOfFile: imagePath) ?? UIImage()
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(uiImage: loadUIImage())
                .resizable()
                .aspectRatio(16/9, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 220)

            VStack(alignment: .leading, spacing: 8) {

                Text("New launch")
                    .font(.visbySemibold(size: 14))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.59, green: 0.10, blue: 0.28))
                    .foregroundColor(.white)
                    .cornerRadius(8)

                Text("Korean facials\nfor a radiant glow")
                    .font(.visbyBold(size: 32))
                    .foregroundColor(.white)
                    .lineLimit(3)

                Text("Starting at ₹1,399")
                    .font(.visbyMedium(size: 16))
                    .foregroundColor(.white)
            }
            .padding(.leading, 20)
            .padding(.bottom, 24)
        }
    }
}

struct ServiceRow: View {
    let avatarName: String
    let title: String
    let tag: String
    let brands: [String]

    var body: some View {
//        NavigationLink(destination: nil) {
            HStack(alignment: .center, spacing: 16) {
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.95))
                    .frame(width: 92, height: 116)
                    .overlay(
                        Image(avatarName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 92, height: 116)
                            .clipped()
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(title)
                            .font(.visbySemibold(size: 20))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.systemGray3))
                    }

                    HStack(spacing: 10) {
                        Text(tag)
                            .font(.visbySemibold(size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color(white: 0.92))
                            .cornerRadius(8)

                        Spacer()
                    }

                    HStack(spacing: 20) {
                        ForEach(brands, id: \.self) { b in
                            Text(b)
                                .font(.visbyMedium(size: 14))
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.vertical, 10)
        }
//        .buttonStyle(PlainButtonStyle())
//    }
}

struct ServiceDetailView: View {
    let title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.visbyBold(size: 28))
            Spacer()
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
