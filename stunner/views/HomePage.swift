import SwiftUI

struct HomePage: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                TabView {
                    DiscoverView()
                        .tabItem {
                            Image(systemName: "sparkles.tv")
                            Text("Discover")
                        }
                    
                    ShopView()
                        .tabItem {
                            Image(systemName: "bag.fill")
                            Text("Shop")
                        }
                    
                    CartView()
                        .tabItem {
                            Image(systemName: "cart.fill")
                            Text("Cart")
                        }
                    
                    PlaceholderView(title: "Member")
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Member")
                        }
                }
                .accentColor(.main)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
