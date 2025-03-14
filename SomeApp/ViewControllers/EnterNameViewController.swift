//
//  EnterNameViewController.swift
//  SomeApp
//
//  Created by Даниял on 14.03.2025.
//

import UIKit

class EnterNameViewController: UIViewController {

    private var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Name"
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
        title = "Enter Name"
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
        userData.name = textField.text
        let enterBirthdayViewController = EnterBirthdayViewController()
        enterBirthdayViewController.setup(userData: userData)
        navigationController?.pushViewController(enterBirthdayViewController, animated: true)
    }
}
