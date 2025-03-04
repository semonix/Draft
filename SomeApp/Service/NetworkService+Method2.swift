import UIKit

struct HTTPMethod {
    static let get = HTTPMethod.init(rawValue: "GET")
    static let post = HTTPMethod.init(rawValue: "POST")
    static let put = HTTPMethod.init(rawValue: "PUT")
    static let delete = HTTPMethod.init(rawValue: "DELETE")
    
    let rawValue: String
}
enum NetworkError: Error {
    case badData
    case badResponse
    case badRequest
    case badDecode
    case badEncode
    case unknown(String)
}
protocol NetworkProtocol {
    func fetchData<T: Decodable>(
        url: URL,
        comletion: @escaping (Result<T, NetworkError>) -> Void
    )
}
final class NetworkService {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 250
        return URLSession(configuration: configuration)
    }
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    /// Этот метод получает данные из сети и декодирует их в указанный тип модели
    func fetchData<T: Decodable>(
        url: URL,
        httpMethod: HTTPMethod,
        body: Encodable? = nil,
        headers: [String : String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let body {
            do {
                request.httpBody = try encoder.encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.badEncode))
                return
            }
        }
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        /// Создаём задачу для получения данных
        session.dataTask(with: request) { data, response, error in
            /// Проверяем, если ли ошибка или данные
            guard let data, error == nil else {
                completion(.failure(.badData))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            /// для просмотра body of response
//            let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                    
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.badDecode))
                }
            case 400:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.unknown("Дефолтная ошибка, что поделать...")))
            }
        }.resume()
    }
}
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
    //    ViewController()
}
