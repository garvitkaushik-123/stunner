import SwiftUI
import UIKit

// ServiceProductPage.swift
// Auto-generated SwiftUI replica of the provided design image.
// NOTE: This file references the uploaded image at path: /mnt/data/IMG_5862E9A7F324-1.jpeg
// The host will transform that path into a usable URL in previews or at runtime. If you run locally,
// copy the image into your asset catalog and replace the heroImage loader.

struct ServiceProductPage: View {
    // Path to the uploaded image (developer provided). Replace if needed.
    private let heroImagePath = "/mnt/data/IMG_5862E9A7F324-1.jpeg"

    var body: some View {
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
}

// MARK: - Hero Section

struct HeroSection: View {
    let imagePath: String

    private func loadUIImage() -> UIImage {
        // Try to load from given file path; fallback to empty image.
        if let ui = UIImage(contentsOfFile: imagePath) {
            return ui
        }
        return UIImage()
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Full-width hero image
            Image(uiImage: loadUIImage())
                .resizable()
                .aspectRatio(16/9, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipped()

            // Gradient overlay to match the darkened left side in the reference
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0.0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 220)
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                // small badge
                Text("New launch")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.59, green: 0.10, blue: 0.28))
                    .foregroundColor(.white)
                    .cornerRadius(8)

                Text("Korean facials\nfor a radiant glow")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(3)

                Text("Starting at ₹1,399")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
            }
            .padding(.leading, 20)
            .padding(.bottom, 24)
        }
        .cornerRadius(0)
    }
}

// MARK: - Service Row

struct ServiceRow: View {
    let avatarName: String
    let title: String
    let tag: String
    let brands: [String]

    var body: some View {
        NavigationLink(destination: ServiceDetailView(title: title)) {
            HStack(alignment: .center, spacing: 16) {
                // Avatar placeholder rectangle (rounded)
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.95))
                    .frame(width: 92, height: 116)
                    .overlay(
                        // In a real project, replace this with Image(avatarName)
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 54, height: 54)
                                .foregroundColor(.gray)
                        }
                    )

                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Text(title)
                            .font(.system(size: 20, weight: .bold))

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.systemGray3))
                    }

                    HStack(spacing: 10) {
                        Text(tag)
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color(white: 0.92))
                            .cornerRadius(8)

                        Spacer()
                    }

                    // Brands row (light gray text resembling logos)
                    HStack(spacing: 20) {
                        ForEach(brands, id: \ .self) { b in
                            Text(b)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.vertical, 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Detail View Placeholder

struct ServiceDetailView: View {
    let title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
            Spacer()
        }
        .padding()
        .navigationTitle(title)
    }
}

// MARK: - Preview

struct ServiceProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ServiceProductPage()
    }
}
