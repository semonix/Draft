import UIKit

protocol PresenterInput {
    var output: PresenterOutput { get }
}
protocol PresenterOutput {
    var navigationController: UINavigationController? { get }
}
protocol ViewInput: AnyObject {
    var presenter: ViewOutput? { get }
    func showError(_ message: String)
}
protocol InteractorInput {
    var presenter: InteractorOutput? { get }
    func createAccount(withLogin login: String, password: String)
}
protocol RouterInput {
    func openAuthScreen(withLogin login: String)
    var navigationController: UINavigationController? { get }
}
class Presenter {
    var interactor: InteractorInput
    var router: RouterInput
    weak var view: ViewInput?
    
    init(interactor: InteractorInput, router: RouterInput, view: ViewInput) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}
// MARK: - FROM VIEW
extension Presenter: ViewOutput {
    func userSelectCreateAccount(withLogin login: String, password: String) {
        interactor.createAccount(withLogin: login, password: password)
    }
}
// MARK: - FROM INTERACTOR
extension Presenter: InteractorOutput {
    func didReceive(error: String) {
        view?.showError(error)
    }
    func didCreateAccount(withLogin login: String) {
        router.openAuthScreen(withLogin: login)
    }
}
