import SwiftUI

struct SplashScreen: View {
    @Binding var showSplash: Bool

    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()

            Text("STUNNER")
                .font(.dmSans(size: 36))
                .foregroundColor(.white)
                .textCase(.uppercase)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
