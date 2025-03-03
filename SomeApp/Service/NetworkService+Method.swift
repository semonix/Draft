//import UIKit
//
//struct HTTPMethod {
//    static let get = HTTPMethod(rawValue: "GET")
//    static let post = HTTPMethod(rawValue: "POST")
//    static let put = HTTPMethod(rawValue: "PUT")
//    static let delete = HTTPMethod(rawValue: "DELETE")
//
//    let rawValue: String
//}
//enum NetworkError: Error {
//    case badData
//    case badResponse
//    case badRequest
//    case badDecode
//    case badEncode
//    case unknown(String)
//}
//protocol NetworkProtocol {
//    func fetchData<T: Decodable>(
//        url: URL,
//        completion: @escaping (Result<T, NetworkError>) -> Void
//    )
//}
//final class NetworkService {
//    private let decoder = JSONDecoder()
//    private var session: URLSession {
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = true
//        configuration.waitsForConnectivity = true
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 250
//        return URLSession(configuration: configuration)
//    }
//    init() {
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//    }
//    /// Этот метод получает данные из сети и декодирует их в указанный тип модели
//    func fetchData<T: Codable>(
//        url: URL,
//        httpMethod: HTTPMethod,
//        body: Encodable? = nil,
//        headers: [String : String]? = nil,
//        completion: @escaping (Result<T, NetworkError>) -> Void
//    ) {
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        /// Создаём задачу для получения данных
//        session.dataTask(with: request) { data, response, error in
//        /// Убеждаемся, что получены данные и нет ошибки
//            guard let data, error == nil else {
//                completion(.failure(.badData))
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failure(.badResponse))
//                return
//            }
//            switch response.statusCode {
//            case 200...999:
//                /// Пытаемся декодировать данные
//                do {
//                    let decodedData = try self.decoder.decode(T.self, from: data)
//                    completion(.success(decodedData))
//                } catch {
//                    completion(.failure(.badDecode))
//                }
//            case 400:
//                completion(.failure(.badRequest))
//            default:
//                completion(.failure(.unknown("Не хватает параметра X")))
//            }
//        }.resume()
//    }
//}
//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: ViewController())
//    //    ViewController()
//}
