import SwiftUI

struct SplashScreenPage: View {
    @Binding var showSplash: Bool
    @State private var animateLetters = false

    private let letters = Array("Be Stunning")

    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()

            VStack(spacing: 10) {
                Text("STUNNER")
                    .font(.dmSans(size: 36))
                    .foregroundColor(.white)
                    .textCase(.uppercase)

                // Animated "Be Stunning" tagline
                HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { index in
                        Text(String(letters[index]))
                            .foregroundColor(.white)
                            .opacity(animateLetters ? 1 : 0)
                            .scaleEffect(animateLetters ? 1 : 0.7, anchor: .bottom)
                            .animation(
                                .easeInOut(duration: 0.6)
                                    .delay(Double(index) * 0.05),
                                value: animateLetters
                            )
                    }
                }
            }
        }
        .onAppear {
            animateLetters = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
