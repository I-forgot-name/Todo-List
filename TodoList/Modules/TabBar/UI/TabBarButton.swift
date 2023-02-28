//
//  TabBarButton.swift
//  TodoList
//
//  Created by MacBook Pro on 23.02.2023.
//

import SwiftUI

struct TabBarButton: View {

    let imageName: String
    let isActive: Bool

    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .foregroundColor(isActive ? .main: .main.opacity(0.5))
                    .scaledToFit()
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}
