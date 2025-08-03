import SwiftUI

struct DiscoverPage: View {
    let reelsData: [ReelData] = {
        // Use local SampleVideo.mov file instead of remote URLs
        if let videoURL = Bundle.main.url(forResource: "SampleVideo", withExtension: "mov"), let videoURL1 = Bundle.main.url(forResource: "SampleVideo1", withExtension: "mov"), let videoURL2 = Bundle.main.url(forResource: "SampleVideo2", withExtension: "mov") {
            return [
                ReelData(videoURL: videoURL.absoluteString, brandName: "Miraggio", brandImage: "miraggio"),
                ReelData(videoURL: videoURL1.absoluteString, brandName: "Comet", brandImage: "comet"),
                ReelData(videoURL: videoURL2.absoluteString, brandName: "Fraganote", brandImage: "fraganote")
            ]
        } else {
            return [
                ReelData(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Beauty.mp4", brandName: "Miraggio", brandImage: "miraggio"),
                ReelData(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", brandName: "Blair", brandImage: "blair"),
                ReelData(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4", brandName: "Callie", brandImage: "callie"),
                ReelData(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Beauty.mp4", brandName: "Martina", brandImage: "martina"),
                ReelData(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", brandName: "River", brandImage: "river"),
                ReelData(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4", brandName: "Hazelnut", brandImage: "hazelnut")
            ]
        }
    }()
    
    @State private var showProductPage = false
    @State private var visibleReelIndex: Int = 0
    @State private var isPageVisible: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            
            StunnerHeader()
            
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(reelsData.enumerated()), id: \.element.id) { index, reel in
                            ReelVisibilityDetector(index: index, visibleReelIndex: $visibleReelIndex, parentSize: geo.size) {
                                ReelPlayerView(
                                    reelData: reel,
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
            
            Spacer()
        }
    }
}

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
