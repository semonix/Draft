import UIKit

typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var flowCompletionHandler: CoordinatorHandler? { get set }
    func start()
}
protocol FlowController {
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
