import SwiftUI
import AVKit

struct ReelPlayerView: View {
    let videoURL: String
    @Binding var showProductPage: Bool
    @Binding var shouldPlay: Bool
    @State private var player: AVPlayer?
    @State private var isLiked: Bool = false
    @State private var likeCount: Int = Int.random(in: 100...9999) // Random like count for demo

    var body: some View {
        ZStack {
            if let player = player {
                VideoPlayer(player: player)
                    .disabled(true)
                    .onAppear {
                        if shouldPlay {
                            player.play()
                        }
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { _ in
                            player.seek(to: .zero)
                            if shouldPlay {
                                player.play()
                            }
                        }
                    }
                    .onChange(of: shouldPlay) { newValue in
                        if newValue {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }
                    .ignoresSafeArea()
            }

            // Instagram-style action buttons on the right side
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        // Like button
                        VStack(spacing: 4) {
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    isLiked.toggle()
                                    if isLiked {
                                        likeCount += 1
                                    } else {
                                        likeCount -= 1
                                    }
                                }
                            }) {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .font(.system(size: 28))
                                    .foregroundColor(isLiked ? .red : .white)
                                    .scaleEffect(isLiked ? 1.2 : 1.0)
                            }
                            
                            Text("\(likeCount)")
                                .font(.visbyMedium(size: 12))
                                .foregroundColor(.white)
                        }
                        
                        // Comment button
                        VStack(spacing: 4) {
                            Button(action: {
                                // TODO: Implement comment functionality
                            }) {
                                Image(systemName: "message")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                            }
                            
                            Text("\(Int.random(in: 10...500))")
                                .font(.visbyMedium(size: 12))
                                .foregroundColor(.white)
                        }
                        
                        // Shop button
                        VStack(spacing: 4) {
                            Button(action: {
                                showProductPage = true
                            }) {
                                Image(systemName: "bag")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Shop")
                                .font(.visbyMedium(size: 12))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 20)
                }
                
                Spacer()
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

