import Foundation
// MARK: - PROTOCOLS
protocol HomeViewInput: AnyObject {
    func set(state: HomeViewState)
}
protocol HomeViewOutput: AnyObject {
    func viewDidLoad()
}
protocol HomeView: HomeViewInput, TransitionHandler {
    var output: HomeViewOutput! { get set }
}
enum HomeViewState {
    case data
    case refundSuccess
    case refundFailed(_ error: String)
}
// MARK: - HOMEPRESENTER
final class HomePresenter {
    
    unowned var view: HomeViewInput
    
    private let interactor: HomeInteractorInput
    private let router: HomeRouterInput
    
    private weak var detailedScreen: DetailedScreenModuleInput?
    
    init(view: HomeViewInput, interactor: HomeInteractorInput, router: HomeRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: - HomeViewOutPut
extension HomePresenter: HomeViewOutput {
    func viewDidLoad() {
        interactor.obtainData(1)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.detailedScreen?.dismissDetailedScreen()
        }
        print("Hello Presenter with viewDidload")
    }
}
// MARK: - HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    
    func setSuccessfulObtainData() {
        print("Hello Presenter with setSuccessfulObtainData")
        view.set(state: .data)
    }
    func setFailedObtainData(for error: String) {
        print("Hello Presenter with setFairledObtainData")
        view.set(state: .refundFailed(error))
    }
}
