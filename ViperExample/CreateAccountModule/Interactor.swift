import Foundation

protocol InteractorOutput: AnyObject {
    func didReceive(error: String)
    func didCreateAccount(withLogin login: String)
}
class Interactor  {
    weak var presenter: InteractorOutput?
}
// MARK: - FROM PRESENTER
extension Interactor: InteractorInput {
    func createAccount(withLogin login: String, password: String) {
        let _ = Account(login: login, password: password)
        // some ...
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.presenter?.didCreateAccount(withLogin: login)
        }
    }
}
