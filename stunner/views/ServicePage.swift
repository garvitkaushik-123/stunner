import SwiftUI

struct ServicePage: View {

    // MARK: - Grid Layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Dummy Data
    struct ServiceItem: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
        let hasSale: Bool
    }

    private let services: [ServiceItem] = [
        ServiceItem(title: "Korean facials for Women", imageName: "service1", hasSale: false),
        ServiceItem(title: "Hare Dressing & beauty", imageName: "service2", hasSale: false),
        ServiceItem(title: "Cleaning & Pest Control", imageName: "service3", hasSale: false),
        ServiceItem(title: "Electrician", imageName: "service4", hasSale: false),
        ServiceItem(title: "Native Water Purifier", imageName: "service5", hasSale: false),
        ServiceItem(title: "Painting & Waterproofing", imageName: "service6", hasSale: false),
        ServiceItem(title: "AC & Appliance Repair", imageName: "service7", hasSale: false),
        ServiceItem(title: "Wall makeover by Revamp", imageName: "service8", hasSale: false),
        ServiceItem(title: "Native Smart Door Locks", imageName: "service9", hasSale: false)
    ]

    var body: some View {
        VStack(spacing: 0) {

            StunnerHeader()

            // MARK: - Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 14))
                            .foregroundColor(.black)

                        Text("Block A")
                            .font(.visbySemibold(size: 16))
                            .foregroundColor(.black)

                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.7))
                    }

                    Text("Shivalik Colony - Malviya Nagar - New Delhi")
                        .font(.visbyMedium(size: 12))
                        .foregroundColor(Color.discover)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            // MARK: - Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                Text("Search for ‘AC service’")
                    .font(.visbyMedium(size: 14))
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 16)
            .padding(.top, 12)

            // MARK: - Grid of Services
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {

                    ForEach(services) { service in
                        NavigationLink(destination: ServiceProductPage()) {
                            GeometryReader { geo in
                                VStack(spacing: 8) {
                                    
                                    let side = geo.size.width  // width == height → square

                                    ZStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.gray.opacity(0.1))

                                        Image(service.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: side, height: side)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                    }
                                    .frame(width: side, height: side)

                                    Text(service.title)
                                        .font(.visbyMedium(size: 12))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .frame(height: 140)   // IMPORTANT: same as expected square width per column
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 20)

                // MARK: - Offers
                VStack(alignment: .leading, spacing: 8) {
                    Text("Offers & discounts")
                        .font(.visbySemibold(size: 18))
                        .foregroundColor(.black)

                    OffersSection()
                }
                .padding(.horizontal, 16)
                .padding(.top, 30)
                .padding(.bottom, 50)
            }
        }
        .background(Color.stunner.ignoresSafeArea())
        .navigationBarHidden(true)
        .statusBarHidden(true)
    }
}

struct ServicePage_Previews: PreviewProvider {
    static var previews: some View {
        ServicePage()
    }
}
