import Foundation
// MARK: - PROTOCOLS
protocol HomeInteractorInput: AnyObject {
    func obtainData(_ userID: Int)
}
protocol HomeInteractorOutput: AnyObject {
    func setSuccessfulObtainData()
    func setFailedObtainData(for error: String)
}
protocol WeatherAPI {
    func getWeather()
}
final class WeatherService: WeatherAPI {
    func getWeather() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            print("Weather API HERE!!!!")
        }
    }
}
// MARK: --
final class HomeInteractor {
    
    weak var output: HomeInteractorOutput?
    
    private let weatherService: WeatherAPI
    
    init(weatherService: WeatherAPI) {
        self.weatherService = weatherService
    }
}

extension HomeInteractor: HomeInteractorInput {

    func obtainData(_ userID: Int) {
        print("obtainData from HomeInteractor")
//        output?.setFailedObtainData(for: "Interactor emmited error")
        weatherService.getWeather()
        output?.setSuccessfulObtainData()
    }
}
