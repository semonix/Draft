import UIKit
import SnapKit

class ConformPhoneViewController: UIViewController {

    private var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter code"
        return textField
    }()
    private let nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(ConformPhoneViewController.self, action: #selector(didPressNextButton), for: .touchUpInside)
        return nextButton
    }()
    private var userData: UserData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    private func addSubviews() {

    }
    @objc func didPressNextButton() {
        
    }
}
