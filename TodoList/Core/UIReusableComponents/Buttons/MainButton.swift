//
//  MainButton.swift
//  TodoList
//
//  Created by MacBook Pro on 01.03.2023.
//

import SwiftUI

struct MainButton: View {

    var action: () -> Void
    var title: String

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(height: 44)
                .padding(.horizontal)
                .font(.bold(.title3)())
        }
        .foregroundColor(.white)
        .background(Color.main)
        .clipShape(RoundedRectangle(cornerRadius: 5))

    }
}
