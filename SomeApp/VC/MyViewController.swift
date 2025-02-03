import UIKit
import SnapKit
protocol MyP {
    var computedTypeProperty: Int { get }
}
class MyViewController: UIViewController {
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupLayout()
        setupAppearance()
        setupTargets()

//        afterBlock(seconds: 2, queue: .global(qos: .utility)) {
//            print("Hello")
//        }
        
//        afterBlock(seconds: 2) {
//            self.showAllert()
//        }
    }
}
// MARK: - EXAMPLE OF GCD
extension MyViewController {
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds), execute: completion)
    }
    func showAllert() {
        let alert = UIAlertController(title: nil, message: "message", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
// MARK: - SETUP
extension MyViewController {
    func addSubviews() {
        view.addSubview(button)
    }
    func setupLayout() {
        button.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    func setupAppearance() {
        view.backgroundColor = .systemCyan.withAlphaComponent(0.5)
        button.backgroundColor = .systemRed.withAlphaComponent(0.9)
        button.setTitle("Press", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 37)
    }
    func setupTargets() {
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc func buttonPressed() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: MyViewController())
//    ViewController()
}
