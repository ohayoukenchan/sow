import Combine
import Core
import Infra

@MainActor
public final class SignupViewState: ObservableObject {
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
//
    private let presenter: AuthPresenter?

//    var transition: AnyPublisher<Transition, Never> {
//        transitionSubject.eraseToAnyPublisher()
//    }

    private var cancellables: Set<AnyCancellable> = []

    init(presenter: AuthPresenter?) {
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

    /// viewが表示されたらstoreのカテゴリー取得関数を叩く
    /// リクエストのたびにstartLoadingを書くのは書き漏れしそうなので
    /// 引数に関数を取るようにする
    /// Fetchableとかかな
    func onAppear() async {
//        ApiStateStore.shared.startLoading()
//
//        do {
//            let categoryList = try await presenter?.getTopCategoryList()
//
//            guard let categoryList else { return }
//            TopCategoryStore.shared.setTopCategory(categoryList)
//            ApiStateStore.shared.finishLoading()
//        } catch {
//            ApiStateStore.shared.failLoading(error: error)
//        }
    }

    func onTap() {}
}
