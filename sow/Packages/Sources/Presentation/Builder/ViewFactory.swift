// import UIKit
import Core
import Infra
import SwiftUI

@MainActor
public final class ViewFactory {
    public static let shared = ViewFactory()

    private init() {}

    public func build(screenType: NavigationDestination) -> AnyView {
        switch screenType {
        case .signUp:
            let repository = AuthUserRepositoryImpl()
            let useCase = AuthUserUseCase(authRepository: repository)
            let presenter = AuthPresenter(useCase: useCase)

            let viewState = SignUpViewState(presenter: presenter)

            return AnyView(SignUpViewContainer(viewState: viewState))
        case .home:
            let repository = UserRepositoryImpl()
            let useCase = UserUseCase(userRepository: repository)
            let presenter = UserPresenter(useCase: useCase)

            let viewState = HomeViewState(presenter: presenter)

            return AnyView(HomeViewContainer(viewState: viewState))
        case .logIn:
            let repository = AuthUserRepositoryImpl()
            let useCase = AuthUserUseCase(authRepository: repository)
            let presenter = AuthPresenter(useCase: useCase)

            let signUpState = SignUpViewState(presenter: presenter)

            return AnyView(LogInViewContainer(viewState: signUpState))
        case .welcome:
            return AnyView(WelcomeViewContainer())
        case .logOut:
            let repository = AuthUserRepositoryImpl()
            let useCase = AuthUserUseCase(authRepository: repository)
            let presenter = AuthPresenter(useCase: useCase)

            let signUpState = SignUpViewState(presenter: presenter)

            return AnyView(LogOutViewContainer(viewState: signUpState))
        }
    }
}
