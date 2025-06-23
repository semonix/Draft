import UIKit

class Assembly {
    static func assembly() -> (router: Router, view: UIViewController) {
        let view = View()
        let interactor = Interactor()
        let router = Router()
        let presenter = Presenter(interactor: interactor, router: router, view: view)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return (router, view)
    }
}














