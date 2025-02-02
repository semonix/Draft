import UIKit
import SnapKit

class MyViewController: UIViewController {
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        title = "vc 1"
        
        view.backgroundColor = .systemCyan.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }
    @objc func pressAction() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initButton()
    }
    func initButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        button.setTitle("Press", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed//.green
        button.layer.cornerRadius = 10
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: MyViewController())
//    ViewController()
}
