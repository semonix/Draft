import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
}
