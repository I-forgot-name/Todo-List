// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen


import UIKit
import SwiftUI

extension UIColor {

    /// 0x8a84e2ff
    static let accent = UIColor(rgbaValue: 0x8a84e2ff)

    convenience init(rgbaValue: UInt32) {
        self.init(
            red: CGFloat((rgbaValue >> 24) & 0xff) / 255,
            green: CGFloat((rgbaValue >> 16) & 0xff) / 255,
            blue: CGFloat((rgbaValue >> 8) & 0xff) / 255,
            alpha: CGFloat((rgbaValue) & 0xff) / 255
        )
    }
}

extension Color {
    /// 0x8a84e2ff
    static let accent = Color(rgbaValue: 0x8a84e2ff)

    init(rgbaValue: UInt32) {
        self.init(
            red: Double((rgbaValue >> 24) & 0xff) / 255,
            green: Double((rgbaValue >> 16) & 0xff) / 255,
            blue: Double((rgbaValue >> 8) & 0xff) / 255,
            opacity: Double((rgbaValue) & 0xff) / 255
        )
    }
}
