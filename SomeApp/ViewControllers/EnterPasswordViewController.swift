import UIKit
import SnapKit

class EnterPasswordViewController: UIViewController {

    private var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        return textField
    }()
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(didPressNextButton), for: .touchUpInside)
        return nextButton
    }()
    private var userData: UserData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    func setup(userData: UserData) {
        self.userData = userData
    }
    private func addSubviews() {
        title = "Enter password"
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [textField, nextButton])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(120)
            make.center.equalToSuperview()
        }
    }
    @objc func didPressNextButton() {
        userData.password = textField.text
        let enterNameViewController = EnterNameViewController()
        enterNameViewController.setup(userData: userData)
        navigationController?.pushViewController(enterNameViewController, animated: true)
    }
}
