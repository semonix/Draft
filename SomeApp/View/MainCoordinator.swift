import UIKit
enum Event {
    case buttonTapped
}
protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func eventOccured(with type: Event)
    func start()
}
protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Event) {
        switch type {
        case .buttonTapped:
            let vc = SecondViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
