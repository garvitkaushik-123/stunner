import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "#000000")
    static let main = Color(hex: "#181818")
    static let secondary = Color(hex: "#4d4e4f")
    static let secondary2 = Color(hex: "#a0a0a0")
    static let white = Color(hex: "#ffffff")
    static let lightGrey = Color(hex: "#eeeeee")
    static let flightGrey = Color(hex: "#f9f9f9")
    static let surface = Color(hex: "#f7f7f7")
    static let critical = Color(hex: "#f03e3e")
    static let warning = Color(hex: "#9391e1")
    static let success = Color(hex: "#3dab25")
    static let yellow = Color(hex: "#f0a750")
    static let pink = Color(hex: "#ec749d")
    static let blue = Color(hex: "#0c74d6")
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
}
