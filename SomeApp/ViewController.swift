import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let key = "counterKey"
    let uds = UserDefaults.standard
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
//        view.backgroundColor = .black
        label.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
        
        label.textAlignment = .center
        counter = uds.integer(forKey: key)
//        if counter == 0 {
//            counter = 1
//        } else {
//            counter += 1
//        }
        counter += 1
        uds.set(counter, forKey: key)

        
        label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 50)
        label.text = String(counter)
    }
    
    
}

@available(iOS 17.0, *)
#Preview {
//    UINavigationController(rootViewController: ViewController())
    ViewController()
}
