import SwiftUI

struct SplashScreenPage: View {
    @Binding var showSplash: Bool
    @State private var animateLetters = false

    private let letters = Array("YOU'RE STUNNING")
    private let fontSize: CGFloat = 12
    private var letterSpacing: CGFloat { fontSize * 0.37 }

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            GeometryReader { geometry in
                ZStack {
                    // Centered logo
                    Image("logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .position(x: geometry.size.width / 2,
                                  y: geometry.size.height / 2)

                    // Tagline 311 points below the image
                    HStack(spacing: letterSpacing) {
                        ForEach(0..<letters.count, id: \.self) { index in
                            Text(String(letters[index]))
                                .font(.visbyMedium(size: fontSize))
                                .foregroundColor(.black)
                                .opacity(animateLetters ? 1 : 0)
                                .scaleEffect(animateLetters ? 1 : 0.7, anchor: .bottom)
                                .animation(
                                    .easeInOut(duration: 0.6)
                                        .delay(Double(index) * 0.05),
                                    value: animateLetters
                                )
                        }
                    }
                    .position(x: geometry.size.width / 2,
                              y: geometry.size.height / 2 + 311)
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

struct SplashScreenPage_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenPage(showSplash: .constant(true))
    }
}
