import UIKit

class Router {
    weak var navigationController: UINavigationController?
}
// MARK: - FROM PRESENTER
extension Router: RouterInput {
    
    func openAuthScreen(withLogin login: String) {
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .systemOrange
        navigationController?.present(secondVC, animated: true)
//        navigationController?.setViewControllers([secondVC], animated: true)
//        navigationController?.pushViewController(secondVC, animated: true)
    }
}
