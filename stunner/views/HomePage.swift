import SwiftUI

struct HomePage: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                TabView {
                    DiscoverPage()
                        .tabItem {
                            Image(systemName: "sparkles.tv")
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
                    
                    PlaceholderPage(title: "Member")
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
