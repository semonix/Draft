import UIKit
// MARK: - PROTOCOLS
protocol HomeRouterInput: AnyObject {
//    func presentDetailScreen(with userID: Int) -> DetailedScreenModuleInput
}
// MARK: --
final class HomeRouter: TransitionHandler {
    func presentModule(with: UIViewController, animated: Bool) -> any DetailedScreenModuleInput {
        <#code#>
    }
    
    weak var transitionHandler: TransitionHandler?
}
extension HomeRouter: HomeRouterInput {
    
    func presentDetailScreen(with userID: Int) -> DetailedScreenModuleInput {
        
        let viewController = DetailedScreenViewController()
        let detailedInput = DetailedScreenAssembly.build(view: viewController)
        
        transitionHandler?.presentModule(with: viewController, animated: true)
        
        return detailedInput as! DetailedScreenModuleInput
    }
}
