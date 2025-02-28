import Foundation

enum NetworkError: Error {
    case badData
    case badResponse
    case badRequest
    case badDecode
    case unknown(String)
}
protocol NetworkProtocol {
    func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
final class NetworkService {
    private let decoder = JSONDecoder()
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true // The default value is true.
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // The default value is 60.
        configuration.timeoutIntervalForResource = 250
        return URLSession(configuration: configuration)
    }
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    /// Этот метод получает данные из сети и декодирует их в указанный тип модели
    func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        /// Создаём задачу для получения данных
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            // Убеждаемся, что получены данные и нет ошибки
            guard let data, error == nil else {
                completion(.failure(.badData))
                return
            }
            /// Приведение URLResponse к HTTPURLResponse используется, когда:
            /// Нужен доступ к HTTP-специфичным данным (статус-код, заголовки)
            /// Необходимо проверить успешность запроса по коду состояния
            /// Работаем с HTTP/HTTPS API (а не FTP/FILE и другими протоколами)
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            switch response.statusCode {
            case 200...299:
                /// Пытаемся декодировать данные
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
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
