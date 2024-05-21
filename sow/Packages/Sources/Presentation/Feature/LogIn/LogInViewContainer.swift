//
//  LogInViewContainer.swift
//
//
//  Created by ohayoukenchan on 2024/04/30.
//

import SwiftUI

public struct LogInViewContainer: View {
    @ObservedObject var viewState: SignUpViewState

    public init(
        viewState: SignUpViewState
    ) {
        self.viewState = viewState
    }

    public var body: some View {
        LogInView(
            email: $viewState.email,
            password: $viewState.password,
            onTapAction: viewState.onTapSignIn
        )
    }
}
