import Foundation

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
// MARK: - HomeViewOutput
extension HomePresenter: HomeViewOutput {
    func viewDidLoad() {
        interactor.obtainData(1)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.detailedScreen?.dismissDetailedScreen()
        }
        print("Hello Presenter with viewDidload")
    }
}
extension HomePresenter: HomeInteractorOutput {
    func setSuccessfulObtainData() {
        <#code#>
    }
    
    func setFailedObtainData(for: String) {
        <#code#>
    }
    
    
}
