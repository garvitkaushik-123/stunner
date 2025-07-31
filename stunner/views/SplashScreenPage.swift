import SwiftUI

struct SplashScreenPage: View {
    @Binding var showSplash: Bool
    @State private var animateLetters = false

    private let letters = Array("You are stunning")

    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()

            VStack(spacing: 10) {
                Text("STUNNER")
                    .font(.visbyExtrabold(size: 36))
                    .foregroundColor(.white)
                    .textCase(.uppercase)

                HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { index in
                        Text(String(letters[index]))
                            .font(.visbyLight(size: 18))
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
