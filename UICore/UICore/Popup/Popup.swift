//
//  Popup.swift
//  UICore
//
//  Created by MacBook Pro on 02.05.2023.
//
import SwiftUI

public struct Popup<T: View>: ViewModifier {
    private let content: T
    @Binding private var isPresented: Bool
    private let alignment: Alignment
    private let direction: Direction
    private let needShadow: Bool

    //    MARK: Init

    init(
        isPresented: Binding<Bool>,
        alignment: Alignment,
        direction: Direction,
        needShadow: Bool,
        @ViewBuilder content: () -> T
    ) {
        self._isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
        self.needShadow = needShadow
        self.content = content()
    }

    //    MARK: Public func

    public func body(content: Content) -> some View {
        build(content: content)
    }

    private func build(content: Content) -> some View {
        VStack {
            if needShadow {
                content
                    .overlay(shadow())
                    .overlay(popupContent())
            } else {
                content
                    .overlay(popupContent())
            }
        }
    }

    //    MARK: Private func

    /// Функция отвечает за отображения контента, в каком виде с какой анимацией
    /// - Returns: Модифицированную View контента для попапа
    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                content
                    .animation(.spring())
                    .transition(.offset(
                        x: 0,
                        y: direction.offset(popupFrame: geometry.frame(in: .global)))
                    )
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: alignment
                    )
            }
        }
    }

    /// Тень затемняющая контент под попапом, так же является множеством точек выхода из состояния показа попапа
    /// - Returns: Затемняющая вью
    @ViewBuilder private func shadow() -> some View {
        if isPresented {
            VStack() {}
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(.gray.opacity(0.3))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isPresented = false
                    }
                }
        }
    }
}

// MARK: Direction

public extension Popup {
    enum Direction {
        case top, bottom

        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            }
        }
    }
}
