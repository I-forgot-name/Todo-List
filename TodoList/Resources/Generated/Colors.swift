// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import UIKit

extension UIColor {


    convenience init(rgbaValue: UInt32) {
        self.init(
            red: CGFloat((rgbaValue >> 24) & 0xff) / 255,
            green: CGFloat((rgbaValue >> 16) & 0xff) / 255,
            blue: CGFloat((rgbaValue >> 8) & 0xff) / 255,
            alpha: CGFloat((rgbaValue) & 0xff) / 255
        )
    }
}
