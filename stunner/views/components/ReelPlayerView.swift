import SwiftUI
import AVKit

struct ReelPlayerView: View {
    let videoURL: String
    @Binding var showProductPage: Bool
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if let player = player {
                VideoPlayer(player: player)
                    .disabled(true)
                    .onAppear {
                        player.play()
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { _ in
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
                    .ignoresSafeArea()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showProductPage = true
                    }) {
                        Text("SHOP NOW")
                            .font(.dmSans(size: 14))
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 40)
                    .padding(.trailing, 20)
                }
            }
        }
        .onAppear {
            if player == nil {
                let avPlayer = AVPlayer(url: URL(string: videoURL)!)
                self.player = avPlayer
            }
        }
    }
}
