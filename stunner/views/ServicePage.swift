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
                
            // MARK: - Header (Location + Cart)
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

//                Button(action: {
//                    print("dfgjjgls")
//                }) {
//                    Image(systemName: "cart")
//                        .font(.system(size: 20))
//                        .foregroundColor(.black)
//                        .padding(10)
//                        .background(Color.white)
//                        .clipShape(Circle())
//                        .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 1)
//                }
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
                    .lineLimit(1)

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
                            VStack(spacing: 10) {
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.1))

                                    Image(service.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(20)

                                    if service.hasSale {
                                        Text("Sale")
                                            .font(.visbySemibold(size: 10))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.green)
                                            .clipShape(Capsule())
                                            .padding(8)
                                    }
                                }
                                .frame(height: 90)

                                Text(service.title)
                                    .font(.visbyMedium(size: 12))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 4)
                        }
                        .buttonStyle(PlainButtonStyle())
//                        VStack(spacing: 10) {
//
//                            ZStack(alignment: .topLeading) {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color.gray.opacity(0.1))
//
//                                Image(service.imageName)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .padding(20)
//
//                                if service.hasSale {
//                                    Text("Sale")
//                                        .font(.visbySemibold(size: 10))
//                                        .foregroundColor(.white)
//                                        .padding(.horizontal, 8)
//                                        .padding(.vertical, 4)
//                                        .background(Color.green)
//                                        .clipShape(Capsule())
//                                        .padding(8)
//                                }
//                            }
//                            .frame(height: 90)
//
//                            Text(service.title)
//                                .font(.visbyMedium(size: 12))
//                                .foregroundColor(.black)
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding(.horizontal, 4)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 20)

                // MARK: - Offers & Discounts
                VStack(alignment: .leading, spacing: 8) {
                    Text("Offers & discounts")
                        .font(.visbySemibold(size: 18))
                        .foregroundColor(.black)
                    
                    OffersSection()
                }
                .padding(.horizontal, 16)
                .padding(.top, 30)
                .padding(.bottom, 50)
//
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(Color.gray.opacity(0.1))
//                        .frame(height: 140)
//                        .overlay(
//                            Text("Your offers banner here")
//                                .font(.visbyMedium(size: 14))
//                                .foregroundColor(.gray)
//                        )
//                }
                
                
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
