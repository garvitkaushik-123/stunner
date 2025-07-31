import SwiftUI

struct DiscoverPage: View {
    let videoURLs: [String] = {
        // Use local SampleVideo.mov file instead of remote URLs
        if let videoURL = Bundle.main.url(forResource: "SampleVideo", withExtension: "mov") {
            return [videoURL.absoluteString, "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"]
        } else {
            return [
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Beauty.mp4",
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
            ]
        }
    }()
    
    @State private var showProductPage = false
    @State private var visibleReelIndex: Int = 0
    @State private var isPageVisible: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(Array(videoURLs.enumerated()), id: \.element) { index, url in
                        ReelVisibilityDetector(index: index, visibleReelIndex: $visibleReelIndex, parentSize: geo.size) {
                            ReelPlayerView(
                                videoURL: url,
                                showProductPage: $showProductPage,
                                shouldPlay: .constant(index == visibleReelIndex && isPageVisible)
                            )
                            .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                }
            }
            .background(
                NavigationLink(destination: ProductPage(), isActive: $showProductPage) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .onAppear {
            isPageVisible = true
        }
        .onDisappear {
            isPageVisible = false
        }
    }
}

// Helper view to detect which reel is most visible
struct ReelVisibilityDetector<Content: View>: View {
    let index: Int
    @Binding var visibleReelIndex: Int
    let parentSize: CGSize
    let content: () -> Content
    
    var body: some View {
        content()
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ReelVisiblePreferenceKey.self, value: [ReelVisibleData(index: index, frame: proxy.frame(in: .global))])
                }
            )
            .onPreferenceChange(ReelVisiblePreferenceKey.self) { values in
                guard let value = values.first else { return }
                let midY = value.frame.midY
                let screenMidY = UIScreen.main.bounds.midY
                // If the center of this reel is closest to the screen center, set as visible
                if abs(midY - screenMidY) < parentSize.height / 2 {
                    visibleReelIndex = value.index
                }
            }
    }
}

struct ReelVisibleData: Equatable {
    let index: Int
    let frame: CGRect
}

struct ReelVisiblePreferenceKey: PreferenceKey {
    static var defaultValue: [ReelVisibleData] = []
    static func reduce(value: inout [ReelVisibleData], nextValue: () -> [ReelVisibleData]) {
        value.append(contentsOf: nextValue())
    }
}
