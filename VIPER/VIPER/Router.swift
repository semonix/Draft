// object
// Entry point

import UIKit

//typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
//    var entry: AnyView? { get }
    static func start() -> (router: AnyRouter, entry: UIViewController)
    func switchToAnotherScreen()
    
    var nav: UINavigationController? { get set }
}
class UserRouter: AnyRouter {
//    var entry: AnyView?
    var nav: UINavigationController?
    
    static func start() -> (router: AnyRouter, entry: UIViewController) {
        let router = UserRouter()
        
        // Assign VIP
        let view: AnyView = UserViewController()
        let presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
//        router.entry = view
        
        return (router: router, entry: view as! UIViewController)
    }
    func switchToAnotherScreen() {
        print(4)
        let vc = UIViewController()
        vc.view.backgroundColor = .brown
        print(5)
//        nav?.pushViewController(vc, animated: true)
        nav?.setViewControllers([vc], animated: true)
        
        print(6)
    }
    deinit {
        print("Router deinitialized")
    }
}
