import Foundation


protocol InteractorOutput: AnyObject {
    func didReceive(error: String)
    func didCreateAccound(withLogin login: String)
}
class Interactor: InteractorInput {
    weak var presenter: InteractorOutput?
    
    func createAccount(withLogin login: String, password: String) {
        let _ = Account(login: login, password: password)
        // some ...
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.presenter?.didCreateAccound(withLogin: login)
        }
    }
}

