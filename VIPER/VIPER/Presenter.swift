import Foundation

// object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter: AnyObject {
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    func switchToAnotherScreen()
    func interactorDidFetchUsers(with result: Result<[User], FetchError>)
}
class UserPresenter: AnyPresenter {
    func switchToAnotherScreen() {
        print(3)
        router?.switchToAnotherScreen()
    }
    

    var router: AnyRouter?
    weak var view: AnyView?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }	
    }
    func interactorDidFetchUsers(with result: Result<[User], FetchError>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    deinit {
        print("Presenter deinitialized")
    }
}
