import Foundation

// object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], FetchError>)
}
class UserPresenter: AnyPresenter {

    var view: AnyView?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }	
    }
    var router: AnyRouter?
    
    func interactorDidFetchUsers(with result: Result<[User], FetchError>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
}
