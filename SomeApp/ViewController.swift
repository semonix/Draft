import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
//        view.backgroundColor = .black
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
        label.textAlignment = .center
//        label.text = "dshbsfgb"
        
    }
    
    
}

@available(iOS 17.0, *)
#Preview {
//    UINavigationController(rootViewController: ViewController())
    ViewController()
}
