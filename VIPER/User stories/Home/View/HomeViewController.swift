import UIKit

final class HomeViewController: UIViewController, HomeView {
    
    var output: HomeViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        output.viewDidLoad()
    }
}
extension HomeViewController {
    
    func set(state: HomeViewState) {
        switch state {
        case .data:
            print("data")
        case .refundSuccess:
            print("refundSuccess")
        case .refundFailed(let error):
            print("refundFailed with error: \(error)")
        }
    }
}
