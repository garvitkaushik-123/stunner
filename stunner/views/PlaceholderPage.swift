import SwiftUI

struct PlaceholderPage: View {
    let title: String

    var body: some View {
        ZStack {
            Color.flightGrey.ignoresSafeArea()
            Text("\(title) Page")
                .font(.visbyBold(size: 24))
                .foregroundColor(.main)
                .textCase(.uppercase)
        }
    }
}
