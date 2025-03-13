import UIKit
import SnapKit
class ViewController: UIViewController {
    
    var coordinator: Coordinator?
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Home"
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(55)
            make.center.equalToSuperview()
        }
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Tap Me!", for: .normal)
    }
    @objc func didTapButton() {
        coordinator?.eventOccured(with: .buttonTapped)
    }
    deinit {
        print("ViewController покинул здание")
    }
}

@available(iOS 17.0, *)
#Preview {
    let navC = UINavigationController()
    let coordinator = MainCoordinator()
    coordinator.navigationController = navC
    coordinator.start()
    return navC
}
