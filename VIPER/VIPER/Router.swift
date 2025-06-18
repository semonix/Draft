// object
// Entry point

import UIKit

//typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: AnyView? { get }
    
    static func start() -> AnyRouter
}
class UserRouter: AnyRouter {
    var entry: AnyView?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Assign VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
}
