import UIKit

protocol TransitionHandler: AnyObject {
    func presentModule(with: UIViewController, animated: Bool) -> DetailedScreenModuleInput
}
