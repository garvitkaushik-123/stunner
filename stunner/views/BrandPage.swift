import SwiftUI

struct BrandPage: View {
    var body: some View {
        VStack {
            Text("Welcome to Brand Page")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("Brand")
        .navigationBarTitleDisplayMode(.inline)
    }
}

