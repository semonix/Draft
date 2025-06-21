import UIKit

class Router {
    weak var navigationController: UINavigationController?
}
extension Router: RouterInput {
    
    func openAuthScreen(withLogin login: String) {
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .systemOrange
        
    }
}
