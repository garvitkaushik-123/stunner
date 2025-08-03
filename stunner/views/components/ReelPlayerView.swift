import SwiftUI
import AVKit
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ReelPlayerView: View {
    let videoURL: String
    @Binding var showProductPage: Bool
    @Binding var shouldPlay: Bool
    @State private var player: AVPlayer?
    @State private var isLiked: Bool = false
    @State private var likeCount: Int = Int.random(in: 100...9999)
    @State private var isShareSheetPresented = false
    @State private var isCommentSheetPresented = false
    @State private var isFollowing: Bool = false

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
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        // Account image
                        Image("miraggio")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 42, height: 42)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        
                        // Account name
                        NavigationLink(destination: BrandPage()) {
                            Text("Miraggio")
                                .font(.visbyMedium(size: 15))
                                .foregroundColor(.white)
                                .tracking(0.3) // 2% of 15 = 0.3
                        }
                        .buttonStyle(PlainButtonStyle())

                        // Follow button with width 65, height 22.65, Visby Semibold 10, letter spacing 5% (0.5)
                        Button(action: {
                            withAnimation {
                                isFollowing.toggle()
                            }
                        }) {
                            Text(isFollowing ? "Following" : "Follow")
                                .font(.visbySemibold(size: 10))
                                .foregroundColor(isFollowing ? .white : .black)
                                .tracking(0.5) // 5% of 10 = 0.5
                                .frame(width: 65, height: 22.65)
                                .background(isFollowing ? Color.clear : Color.white)
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(isFollowing ? Color.white : Color.clear, lineWidth: 1)
                                )
                        }
                    }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 16)
                Spacer()
            }
            .zIndex(100)
            
            HStack() {
                Spacer()
                
                VStack(spacing: 20) {
                    // Like button
                    VStack(spacing: 0.55) {
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
                            .font(.visbySemibold(size: 11))
                            .foregroundColor(.white)
                    }
                    
                    // Comment button
                    VStack(spacing: 0.55) {
                        Button(action: {
                            isCommentSheetPresented = true
                        }) {
                            Image(systemName: "message")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                        
                        Text("\(96)")
                            .font(.visbySemibold(size: 11))
                            .foregroundColor(.white)
                    }
                    
                    // Share button
                    VStack(spacing: 0.55) {
                        Button(action: {
                            isShareSheetPresented = true
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                        
                        Text("Share")
                            .font(.visbySemibold(size: 11))
                            .foregroundColor(.white)
                    }
                    
                    // Shop button
                    VStack(spacing: 0.55) {
                        Button(action: {
                            showProductPage = true
                        }) {
                            Image(systemName: "bag")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                        
                        Text("Shop")
                            .font(.visbySemibold(size: 11))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 20)
                .zIndex(50)
            }
        }
        .onAppear {
            if player == nil {
                let avPlayer = AVPlayer(url: URL(string: videoURL)!)
                self.player = avPlayer
            }
        }
        .sheet(isPresented: $isShareSheetPresented) {
            ShareSheet(activityItems: [videoURL])
        }
        .sheet(isPresented: $isCommentSheetPresented) {
            CommentModalView()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct CommentModalView: View {
    @State private var newComment = ""
    @Environment(\.dismiss) var dismiss
    let comments = [
        ("Sana", "Looks amazing! 🔥"),
        ("Priya", "Where did you get this?"),
        ("Arjun", "Such cool vibes!"),
        ("Mira", "Love the background track ✨"),
        ("Dev", "Nice editing!"),
        ("Aisha", "Want to see more like this!"),
        ("Garvit", "Stunning!")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Grabber and title
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 40, height: 4)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.top, 8)
                Spacer()
            }
            Text("Comments")
                .font(.visbySemibold(size: 18))
                .padding(.top, 12)
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(comments, id: \.0) { name, text in
                        HStack(alignment: .top, spacing: 8) {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Text(String(name.prefix(1)))
                                        .foregroundColor(.white)
                                        .font(.visbyBold(size: 15))
                                )
                            VStack(alignment: .leading, spacing: 4) {
                                Text(name).font(.visbyBold(size: 15))
                                Text(text).font(.visbyRegular(size: 15))
                            }
                            Spacer()
                        }
                    }
                }
                .padding()
            }
            Divider()
            HStack(spacing: 8) {
                TextField("Add a comment...", text: $newComment)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                Button(action: { newComment = "" }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(newComment.isEmpty ? .gray : .blue)
                }
                .disabled(newComment.isEmpty)
            }
            .padding(.all, 16)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
    }
}


struct ReelPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State private var showProductPage = false
        @State private var shouldPlay = false
        
        var body: some View {
            ReelPlayerView(
                videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Beauty.mp4",
                showProductPage: $showProductPage,
                shouldPlay: $shouldPlay
            )
        }
    }
}

struct CommentModalView_Previews: PreviewProvider {
    static var previews: some View {
        CommentModalView()
    }
}
