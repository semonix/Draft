import UIKit

protocol DetailedScreenDependency {
    static func build(view: UIViewController) -> UIViewController 
}
final class DetailedScreenAssembly: DetailedScreenDependency {

    static func build(view: UIViewController) -> UIViewController {
        UIViewController() 
    }
}
