//
//  View+Popup.swift
//  UICore
//
//  Created by MacBook Pro on 04.05.2023.
//

import SwiftUI

public extension View {
    func popup<T: View>(
        isPresented: Binding<Bool>,
        alignment: Alignment = .center,
        direction: Popup<T>.Direction = .bottom,
        needShadow: Bool = false,
        @ViewBuilder content: () -> T
    ) -> some View {
        modifier(
            Popup(
                isPresented: isPresented,
                alignment: alignment,
                direction: direction,
                needShadow: needShadow,
                content: content
            )
        )
    }
}
