import SwiftUI

struct HomePage: View {
    var body: some View {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    VStack(spacing: 0) {
                        TabView {
                            DiscoverPage()
                                .tabItem {
                                    Image(systemName: "magnifyingglass")
                                    Text("Discover")
                                }

                            ShopPage()
                                .tabItem {
                                    Image(systemName: "bag.fill")
                                    Text("Shop")
                                }

                            CartPage()
                                .tabItem {
                                    Image(systemName: "cart.fill")
                                    Text("Cart")
                                }

                            MemberPage()
                                .tabItem {
                                    Image(systemName: "person.crop.circle.fill")
                                    Text("Member")
                                }
                        }
                        .accentColor(.main) // Selected icon tint color
                    }
                }
            }
        }
}
