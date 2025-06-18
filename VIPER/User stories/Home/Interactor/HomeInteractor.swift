import Foundation

final class HomeInteractor {
    
    weak var output: HomeInteractorOutput?
}

extension HomeInteractor: HomeInteractorInput {
    func obtainData(_ userID: Int) {
        print("obtainData from HomeInteractor")
        output?.setSuccessfulObtainData()
        output?.setFailedObtainData(for: "Interactor emmited error")
    }
}
