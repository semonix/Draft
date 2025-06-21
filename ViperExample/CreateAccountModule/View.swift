import UIKit


protocol ViewOutput {
    func userSelectCreateAccount(withLogin login: String, password: String)
}

class View: UIViewController, ViewInput {
    var presenter: ViewOutput?
    
    @objc func buttonPressed() {
        presenter?.userSelectCreateAccount(withLogin: "login", password: "password")
    }
    func showError(_ message: String) {
        print(message)
    }
}












