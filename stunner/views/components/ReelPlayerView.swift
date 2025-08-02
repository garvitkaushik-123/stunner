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
    @State private var likeCount: Int = Int.random(in: 100...9999) // Random like count for demo
    @State private var isShareSheetPresented = false
    @State private var isCommentSheetPresented = false

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
                                isCommentSheetPresented = true
                            }) {
                                Image(systemName: "message")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                            }
                            
                            Text("\(Int.random(in: 10...500))")
                                .font(.visbyMedium(size: 12))
                                .foregroundColor(.white)
                        }
                        
                        // Share button
                        VStack(spacing: 4) {
                            Button(action: {
                                isShareSheetPresented = true
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Share")
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
        .sheet(isPresented: $isShareSheetPresented) {
            ShareSheet(activityItems: [videoURL])
        }
        .sheet(isPresented: $isCommentSheetPresented) {
            CommentModalView()
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
            ("Aisha", "Want to see more like this!")
        ]
        var body: some View {
            VStack(spacing: 0) {
                // Grabber and title
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 2).frame(width: 40, height: 4).foregroundColor(.gray.opacity(0.3)).padding(.top, 8)
                    Spacer()
                }
                Text("Comments")
                    .font(.headline)
                    .padding(.top, 12)
                Divider()
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(comments, id: \.0) { name, text in
                            HStack(alignment: .top, spacing: 8) {
                                Circle().fill(Color.black).frame(width: 32, height: 32).overlay(Text(String(name.prefix(1))).foregroundColor(.white).font(.subheadline.bold()))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(name).font(.subheadline.bold())
                                    Text(text).font(.subheadline)
                                }
                                Spacer()
                            }
                        }
                    }.padding()
                }
                Divider()
                HStack(spacing: 8) {
                    TextField("Add a comment...", text: $newComment)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    Button(action: { newComment = "" }) {
                        Image(systemName: "arrow.up.circle.fill").font(.system(size: 24)).foregroundColor(newComment.isEmpty ? .gray : .blue)
                    }.disabled(newComment.isEmpty)
                }.padding(.all, 16)
            }.background(Color(UIColor.systemBackground)).cornerRadius(16)
        }
    }
}
