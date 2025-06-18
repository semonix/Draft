import Foundation

protocol HomeInteractorInput {
    func obtainData(_ userID: Int)
}
protocol HomeInteractorOutput: AnyObject {
    func setSuccessfulObtainData()
    func setFailedObtainData(for: String)
    
}
