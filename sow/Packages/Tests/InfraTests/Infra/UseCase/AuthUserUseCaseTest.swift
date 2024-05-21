import FirebaseAuth
import Foundation
import Nimble
import Quick

@testable import Core
@testable import Infra

final class AuthUserUseCaseTest: AsyncSpec {
    override class func spec() {
        var repository = MockAuthUserRepository()

        describe("AuthUserUseCase") {
            beforeEach {
                repository = MockAuthUserRepository()
            }

            context("signIn") {
                it("signInがcallされる") {
                    let useCase = AuthUserUseCase(authRepository: repository)

                    do {
                        _ = try await useCase.signIn(email: "test", password: "test")
                    } catch {
                        if let error = error as? AuthErrorCode {
                            expect(error.code).to(equal(.emailAlreadyInUse))
                        }
                    }
                }
            }
        }
    }
}
