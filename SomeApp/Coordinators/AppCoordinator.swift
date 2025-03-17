import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?
    
    private var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let isAuth = false
        
        if isAuth {
            showMainFlow()
        } else {
            showRegistrationFlow()
        }
    }
    private func showRegistrationFlow() {
        let registrationCoordinator = CoordinatorFactory().createRegistrationCoordinator(navigationController: navigationController)
        childCoordinators.append(registrationCoordinator)
        registrationCoordinator.flowCompletionHandler = { [weak self] in
            self?.showMainFlow()
        }
        
        registrationCoordinator.start()
    }
    private func showMainFlow() {
        navigationController.setViewControllers([MainViewController()], animated: true)
    }
}
