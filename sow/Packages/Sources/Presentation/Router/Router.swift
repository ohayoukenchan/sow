// import UIKit
import Core
import Infra
import SwiftUI

public final class DependencyBuilder {
    public static let shared = DependencyBuilder()

    private init() {}

    @MainActor public func build(screenType: NavigationDestination) -> some View {
        switch screenType {
        case .signup:
            let repository = AuthUserRepositoryImpl()
            let useCase = AuthUserUseCase(authRepository: repository)
            let presenter = AuthPresenter(useCase: useCase)

            let signUpState = SignupViewState(presenter: presenter)

            return SignupViewContainer(viewState: signUpState)
        }
    }
}
