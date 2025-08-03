import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "#000000")
    static let main = Color(hex: "#181818")
    static let secondary = Color(hex: "#4d4e4f")
    static let secondary2 = Color(hex: "#a0a0a0")
    static let white = Color(hex: "#f1f1f1")
    static let lightGrey = Color(hex: "#eeeeee")
    static let flightGrey = Color(hex: "#f9f9f9")
    static let surface = Color(hex: "#f7f7f7")
    static let critical = Color(hex: "#f03e3e")
    static let warning = Color(hex: "#9391e1")
    static let success = Color(hex: "#3dab25")
    static let yellow = Color(hex: "#f0a750")
    static let pink = Color(hex: "#ec749d")
    static let blue = Color(hex: "#0c74d6")
    static let discover = Color(hex: "#969696")
    static let backdrop = Color.black.opacity(0.2)
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}

extension Font {
    static func dmSans(size: CGFloat) -> Font {
        .custom("DM Sans", size: size)
    }
    
    // Visby Font Family Extensions
    static func visbyThin(size: CGFloat) -> Font {
        .custom("VisbyThin", size: size)
    }
    
    static func visbyThinItalic(size: CGFloat) -> Font {
        .custom("VisbyThin Italic", size: size)
    }
    
    static func visbyLight(size: CGFloat) -> Font {
        .custom("VisbyLight", size: size)
    }
    
    static func visbyLightItalic(size: CGFloat) -> Font {
        .custom("VisbyLight Italic", size: size)
    }
    
    static func visbyRegular(size: CGFloat) -> Font {
        .custom("VisbyRegular", size: size)
    }
    
    static func visbyItalic(size: CGFloat) -> Font {
        .custom("VisbyItalic", size: size)
    }
    
    static func visbyMedium(size: CGFloat) -> Font {
        .custom("VisbyMedium", size: size)
    }
    
    static func visbyMediumItalic(size: CGFloat) -> Font {
        .custom("VisbyMedium Italic", size: size)
    }
    
    static func visbySemibold(size: CGFloat) -> Font {
        .custom("VisbySemibold", size: size)
    }
    
    static func visbySemiboldItalic(size: CGFloat) -> Font {
        .custom("VisbySemibold Italic", size: size)
    }
    
    static func visbyBold(size: CGFloat) -> Font {
        .custom("VisbyBold", size: size)
    }
    
    static func visbyBoldItalic(size: CGFloat) -> Font {
        .custom("VisbyBold Italic", size: size)
    }
    
    static func visbyExtrabold(size: CGFloat) -> Font {
        .custom("VisbyExtrabold", size: size)
    }
    
    static func visbyExtraboldItalic(size: CGFloat) -> Font {
        .custom("VisbyExtrabold Italic", size: size)
    }
    
    static func visbyHeavy(size: CGFloat) -> Font {
        .custom("VisbyHeavy", size: size)
    }
    
    static func visbyHeavyItalic(size: CGFloat) -> Font {
        .custom("VisbyHeavy Italic", size: size)
    }
}

struct StunnerHeader: View {
    var showBackButton: Bool = false
    var onBackButtonTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    onBackButtonTapped?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.primary)
                }
                .frame(width: 44, height: 44)
            } else {
                Spacer()
                    .frame(width: 44, height: 44)
            }
            
            Spacer()
            
            Image("logo1")
                .resizable()
                .scaledToFit()
                .frame(width: 153, height: 15)
            
            Spacer()
            
            Spacer()
                .frame(width: 44, height: 44)
        }
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
