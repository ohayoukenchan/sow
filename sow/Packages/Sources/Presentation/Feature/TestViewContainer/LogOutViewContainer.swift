//
//  LogOutViewContainer.swift
//
//
//  Created by ohayoukenchan on 2024/04/30.
//

import SwiftUI

public struct LogOutViewContainer: View {
    @ObservedObject var viewState: SignUpViewState

    public var body: some View {
        Text("test3")
            .onTapGesture {
                viewState.logout()
            }
    }
}
