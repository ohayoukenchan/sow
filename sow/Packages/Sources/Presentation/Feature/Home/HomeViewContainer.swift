//
//  HomeViewContainer.swift
//
//
//  Created by ohayoukenchan on 2024/04/30.
//

import SwiftUI

public struct HomeViewContainer: View {
    @EnvironmentObject var appRouterState: AppRouterState

    @ObservedObject var viewState: HomeViewState

    @State var selection = 1

    var viewFactory = ViewFactory.shared

    public var body: some View {
        TabView(selection: $selection) {
            RouterContainer(content: {
                Test1ViewContainer(name: viewState.user?.name)
            }, navigation: $appRouterState.homePath)
                .tabItem {
                    Label("Page1", systemImage: "1.circle")
                }
                .tag(1)

            RouterContainer(content: {
                Test2ViewContainer(action: {
                    appRouterState.dispatch(.navigate(to: .welcome))
                })
            }, navigation: $appRouterState.memoPath)
                .tabItem {
                    Label("Page2", systemImage: "2.circle")
                }
                .tag(2)

            RouterContainer(content: {
                viewFactory.build(screenType: .logOut)
            }, navigation: $appRouterState.settingPath)
                .tabItem {
                    Label("Page3", systemImage: "3.circle")
                }
                .tag(3)
        }
        .onAppear {
            appRouterState.dispatch(.changeScene(nextScene: .home))
            viewState.dispatch(.fetchUser)
        }
        .onChange(of: selection, perform: { newValue in
            switch selection {
            case 1:
                appRouterState.dispatch(.changeScene(nextScene: .home))
            case 2:
                appRouterState.dispatch(.changeScene(nextScene: .memo))
            case 3:
                appRouterState.dispatch(.changeScene(nextScene: .setting))
            default:
                appRouterState.dispatch(.changeScene(nextScene: .home))
            }
        })
    }
}
