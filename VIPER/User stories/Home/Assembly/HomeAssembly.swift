import Foundation

final class HomeAssembly {
    static func build(with view: HomeView) {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.output = presenter
        router.TransitionHandler = view
        interactor.output = presenter
    }
}
