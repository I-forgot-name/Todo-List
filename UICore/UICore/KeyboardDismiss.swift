//
//  View+KeyboardDismiss.swift
//  UICore
//
//  Created by MacBook Pro on 02.05.2023.
//

import SwiftUI

#if canImport(UIKit)
public func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
#endif
