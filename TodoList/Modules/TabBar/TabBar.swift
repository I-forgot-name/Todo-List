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
        VStack(alignment: .center, spacing: 0) {

            switch tab {
            case .main:
                mainCoordinator.start()
            case .profile:
                // TODO: when write profile
                Text("Profile")
            }

            Spacer()

            GeometryReader { geo in
                HStack (alignment: .center) {
                    Button(action: {
                        tab = .main
                        tabBarStore.dispatch(.changeTab(.main))
                    }, label: {
                        TabBarButton(imageName: "list.bullet", isActive: tab == .main)
                    })
                    .frame(width: 30, height: 30)

                    Spacer()

                    Button(action: {
                        tab = .profile
                        tabBarStore.dispatch(.changeTab(.profile))
                    }, label: {
                        TabBarButton(imageName: "person.crop.circle", isActive: tab == .profile)
                    })
                    .frame(width: 30, height: 30)
                }
                .padding(.horizontal, 33)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color.white)
            }
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 50, alignment: .bottom)
        }
    }
}
