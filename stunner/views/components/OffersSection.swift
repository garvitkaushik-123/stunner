//
//  OffersSection.swift
//  stunner
//
//  Created by Garvit Kaushik on 23/11/25.
//
import SwiftUI

// MARK: - Offers & Discounts Section
struct OffersSection: View {
    let offers: [OfferItem] = [
        OfferItem(image: "service5", title: "Office Relaxation Pods", subtitle: "Starts at ₹1,299"),
        OfferItem(image: "offer2", title: "Entrance wall makeover", subtitle: "Starts at ₹6,999"),
        OfferItem(image: "offer3", title: "Smart Door Locks Sale", subtitle: "Flat 15% Off"),
    ]

    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 12) {

            TabView(selection: $currentIndex) {
                ForEach(offers.indices, id: \.self) { index in
                    OfferCard(offer: offers[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // hide default dots
            .frame(height: 260)

            SlidingIndicator(numberOfPages: offers.count, currentIndex: currentIndex)
        }
        .padding(.bottom, 10)
    }
}

// MARK: - Offer Card
struct OfferCard: View {
    let offer: OfferItem

    var body: some View {
        ZStack {
            Image(offer.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 50, height: 240)
                .clipped()
                .cornerRadius(20)

//            VStack(alignment: .leading, spacing: 6) {
//                Text(offer.title)
//                    .font(.visbySemibold(size: 20))
//                    .foregroundColor(.black)
//
//                Text(offer.subtitle)
//                    .font(.visbyMedium(size: 14))
//                    .foregroundColor(.black.opacity(0.7))
//
//                Button(action: {}) {
//                    Text("Explore")
//                        .font(.visbyMedium(size: 14))
//                        .foregroundColor(.black)
//                        .padding(.vertical, 10)
//                        .padding(.horizontal, 18)
//                        .background(Color.white)
//                        .cornerRadius(12)
//                }
//                .padding(.top, 6)
//            }
//            .padding(.leading, 24)
//            .padding(.top, 24)
//            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Model
struct OfferItem {
    let image: String
    let title: String
    let subtitle: String
}

struct SlidingIndicator: View {
    var numberOfPages: Int
    var currentIndex: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.3))
                    .frame(width: index == currentIndex ? 20 : 6, height: 6)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentIndex)
            }
        }
    }
}
