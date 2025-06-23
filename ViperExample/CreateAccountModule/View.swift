import UIKit

protocol ViewOutput {
    func userSelectCreateAccount(withLogin login: String, password: String)
}
class View: UIViewController {
    var presenter: ViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonPressed()
    }
    @objc func buttonPressed() {
        presenter?.userSelectCreateAccount(withLogin: "login", password: "password")
    }
}
// MARK: - FROM PRESENTER
extension View: ViewInput {
    func showError(_ message: String) {
        func showError(_ message: String) {
            print(message)
        }
    }
}











