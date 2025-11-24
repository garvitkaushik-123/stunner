import SwiftUI

// MARK: - Colors
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
    static let product = Color(hex: "#555555")
    static let originalPrice = Color(hex: "#969696")
    static let stunner = Color(hex: "#fafafafa")
}

// MARK: - Hex Color Initializers
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") { hexSanitized.removeFirst() }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
            blue: CGFloat(rgb & 0x0000FF) / 255,
            alpha: 1.0
        )
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255
        )
    }
}

// MARK: - Font Extensions
extension Font {
    static func dmSans(size: CGFloat) -> Font { .custom("DM Sans", size: size) }
    static func visbyThin(size: CGFloat) -> Font { .custom("VisbyThin", size: size) }
    static func visbyLight(size: CGFloat) -> Font { .custom("VisbyLight", size: size) }
    static func visbyRegular(size: CGFloat) -> Font { .custom("VisbyRegular", size: size) }
    static func visbyMedium(size: CGFloat) -> Font { .custom("VisbyMedium", size: size) }
    static func visbySemibold(size: CGFloat) -> Font { .custom("VisbySemibold", size: size) }
    static func visbyBold(size: CGFloat) -> Font { .custom("VisbyBold", size: size) }
    static func visbyHeavy(size: CGFloat) -> Font { .custom("VisbyHeavy", size: size) }
}

// MARK: - HEADER HEIGHT CONSTANT
let HEADER_HEIGHT_1: CGFloat = 68     // 44 button + 12 padding top + 12 padding bottom
let HEADER_HEIGHT: CGFloat = 68     // 44 button + 12 padding top + 12 padding bottom

// MARK: - StunnerHeader1
struct StunnerHeader1: View {
    var onHamburgerTapped: (() -> Void)?
    var onSearchTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            Button(action: { onHamburgerTapped?() }) {
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
            }
            .frame(width: 44, height: 44)
            
            Spacer()
            
            Image("logo1")
                .resizable()
                .scaledToFit()
                .frame(width: 153, height: 15)
            
            Spacer()
            
            Button(action: { onSearchTapped?() }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
            }
            .frame(width: 44, height: 44)
        }
        .frame(height: HEADER_HEIGHT_1)
        .background(Color.stunner)
    }
}

// MARK: - StunnerHeader
struct StunnerHeader: View {
    var showBackButton: Bool = false
    var onBackButtonTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: { onBackButtonTapped?() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.primary)
                }
                .frame(width: 44, height: 44)
            } else {
                Spacer().frame(width: 44, height: 44)
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
        .frame(height: HEADER_HEIGHT)
        .background(Color.stunner)
    }
}
