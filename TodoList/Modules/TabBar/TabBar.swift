//
//  TabBar.swift
//  TodoList
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI

struct TabBar: View {
    enum Routing: Int {
        case main = 0
        case addTask
    }
    
    @State var routing: Routing = .main
    let mainCoordinator: MainCoordinator

    let tabBarStore: TabBarStore
    @State var tab: TabBarState.Tab = .main


    init(mainCoordinator: MainCoordinator, tabBarStore: TabBarStore) {
        self.tabBarStore = tabBarStore
        self.mainCoordinator = mainCoordinator
    }

    var body: some View {

        switch tab {
        case .main:
            mainCoordinator.start()
        case .profile:
            // TODO: when write profile
            Text("Profile")
        }

        Spacer()

        HStack(alignment: .center, spacing: 50) {
            // TODO: Add to reusable butons
            Button(action: {
                tab = .main
                tabBarStore.dispatch(.changeTab(.main))
            }, label: {
                Image(systemName: "house.fill")
                    .resizable()
                    .foregroundColor(.accent)
                    .scaledToFit()
            })
            .frame(width: 36, height: 36)
            Button(action: {
                // TODO: Write code on action plus task
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.accent)
                    .scaledToFit()
            })
            .frame(width: 36, height: 36)

            }
        .frame(height: 50)
    }
}
