import SwiftUI

struct DiscoverPage: View {
    let videoURLs = [
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
    ]
    
    @State private var showProductPage = false

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(videoURLs, id: \.self) { url in
                        ReelPlayerView(videoURL: url, showProductPage: $showProductPage)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
            }
            .background(
                NavigationLink(destination: ProductPage(), isActive: $showProductPage) {
                    EmptyView()
                }
                .hidden()
            )
            .ignoresSafeArea()
        }
    }
}
