import SwiftUI

struct PlaceholderPage: View {
    let title: String

    var body: some View {
        ZStack {
            Color.flightGrey.ignoresSafeArea()
            Text("\(title) Page")
                .font(.dmSans(size: 24))
                .foregroundColor(.main)
                .textCase(.uppercase)
        }
    }
}
