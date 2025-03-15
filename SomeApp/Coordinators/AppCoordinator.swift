import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var flowCompletionHandler: CoordinatorHandler?
    
    func start() {
        
    }
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
