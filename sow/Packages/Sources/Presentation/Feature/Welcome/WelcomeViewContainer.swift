//
//  WelcomeViewContainer.swift
//
//
//  Created by ohayoukenchan on 2024/04/30.
//

import SwiftUI

public struct WelcomeViewContainer: View {
    @EnvironmentObject var appRouterState: AppRouterState

    public var body: some View {
        RouterContainer(content: {
            VStack {
                Text("SignUp")
                    .onTapGesture {
                        appRouterState.dispatch(.navigate(to: .signUp))
                    }

                Text("LogIn")
                    .onTapGesture {
                        print("(^θ^) \(appRouterState.currentScene)")
                        appRouterState.dispatch(.navigate(to: .logIn))
                    }
            }.onAppear {
                appRouterState.dispatch(.changeScene(nextScene: .signUp))
            }
        }, navigation: $appRouterState.signUpPath)

//            .navigationBarBackButtonHidden()
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(
//                        action: {
//                            appRouterState.dispatch(.pop(of: appRouterState.currentScene))
//                        }, label: {
//                            Image(systemName: "arrow.uturn.backward")
//                        }
//                    ).tint(.black)
//                }
//            }
    }
}

#Preview {
    WelcomeViewContainer()
}
