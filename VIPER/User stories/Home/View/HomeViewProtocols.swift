import Foundation

protocol HomeViewInput: AnyObject {
    func set(state: HomeViewState)
}
protocol HomeViewOutput: AnyObject {
    func viewDidLoad()
}
protocol HomeView: HomeViewInput, TransitionHandler {
    var output: HomeViewOutput! { get set }
}
enum HomeViewState {
    case data
    case refundSuccess
    case refundFailed(_ error: String)
}
