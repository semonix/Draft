import UIKit
import SnapKit

class EnterPhoneViewController: UIViewController, FlowController {
    
    var completionHandler: ((String?) -> ())?

    private var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter phone"
        return textField
    }()
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(didPressNextButton), for: .touchUpInside)
        return nextButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    private func addSubviews() {
        
        title = "Enter phone"
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
        completionHandler?(textField.text)
        
    }
}
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: EnterPhoneViewController())
}
