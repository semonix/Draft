import UIKit

class SecondViewController: UIViewController {
    
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second"
        view.backgroundColor = .blue
    }
    deinit {
        print("SecondViewController покинул здание")
    }
}
