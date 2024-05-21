import Combine
import Core
import Infra

@MainActor
public final class SignUpViewState: ObservableObject {
    //    enum Transition {
    //        case detail(Book)
    //    }
    // state内でしか変更できないようにprivate(set)にしておく
    //    @Published private(set) var topCategory: CategoryListOutput = .init(
    //        categoryTab: .init(idTopCategory: "", topCategoryName: ""),
    //        subCategoryContents: [:]
    //    )
    //    @Published private(set) var apiStatus: ApiStatus = .idle
    //    @Published private(set) var shouldShowProgressView = false
    //    @Published var shouldShowAlertView = false
    //
    //    private let transitionSubject = PassthroughSubject<Transition, Never>()

    @Published var email: String = ""
    @Published var password: String = ""

    private let presenter: AuthPresenter?

    //    var transition: AnyPublisher<Transition, Never> {
    //        transitionSubject.eraseToAnyPublisher()
    //    }

    private var cancellables: Set<AnyCancellable> = []

    public init(presenter: AuthPresenter?) {
        self.presenter = presenter
        //        /// Storeの値を監視してViewに反映
        //        TopCategoryStore.shared.$values.assign(to: &$topCategory)
        //
        //        ApiStateStore.shared.$apiStatus.assign(to: &$apiStatus)
        //
        //        $apiStatus.sink { [weak self] state in
        //            guard let self else { return }
        //            switch state {
        //            case .loading:
        //                self.shouldShowProgressView = true
        //            case .idle:
        //                self.shouldShowProgressView = false
        //            case .failed(let error):
        //                self.shouldShowAlertView = true
        //                self.shouldShowProgressView = false
        //            }
        //        }.store(in: &cancellables)
    }

    func onTap() {
        Task {
            do {
                try await presenter?.signUp(email: email, password: password)
            } catch {
                print("(^θ^) debug : \(error.localizedDescription)")
                // 今は何もしない
            }
        }
    }

    func onTapSignIn() {
        Task {
            do {
                try await presenter?.signIn(email: email, password: password)
            } catch {
                print("(^θ^) debug : \(error.localizedDescription)")
                // 今は何もしない
            }
        }
    }

    func logout() {
        do {
            try presenter?.signOut()
        } catch {
            print("(^θ^) debug : \(error.localizedDescription)")
            // 今は何もしない
        }
    }
}
