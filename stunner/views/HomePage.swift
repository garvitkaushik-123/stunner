import SwiftUI

enum Tab {
    case discover, shop, cart, member
}

struct HomePage: View {
    @State private var selectedTab: Tab = .discover

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .discover: DiscoverPage()
                case .shop: ShopPage()
                case .cart: CartPage()
                case .member: MemberPage()
                }
            }

            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            tabButton(tab: .discover, icon: "sparkles.tv", title: "Discover")
            Spacer()
            tabButton(tab: .shop, icon: "bag.fill", title: "Shop")
            Spacer()
            tabButton(tab: .cart, icon: "cart.fill", title: "Cart")
            Spacer()
            tabButton(tab: .member, icon: "person.crop.circle.fill", title: "Member")
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(Color.white.shadow(radius: 4))
    }

    private func tabButton(tab: Tab, icon: String, title: String) -> some View {
        let isSelected = selectedTab == tab

        return Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .main : .gray)

                Text(title.uppercased())
                    .font(.visbySemibold(size: 9.5))
                    .foregroundColor(isSelected ? .discover : .gray)
                    .tracking(0.57) // 6% of 9.5
            }
        }
    }
}
