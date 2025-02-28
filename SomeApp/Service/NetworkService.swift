//import Foundation
//
//final class NetworkService {
//    
//    private let decoder = JSONDecoder()
//    
//    init() {
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//    }
//    
//    /// Этот метод получает данные из сети и декодирует их в указанный тип модели
//    func fetchData<T: Decodable>(
//        url: URL,
//        completion: @escaping (Result<T, Error>) -> Void) {
//        /// Создаём задачу для получения данных
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            /// Убеждаемся, что получены данные и нет ошибки
//            sleep(3)
//            guard let data, error == nil else {
//                completion(.failure(error!))
//                return
//            }
//            
//            /// Пытаемся декодировать данные
//            do {
//                let decodedData = try self.decoder.decode(T.self, from: data)
//                completion(.success(decodedData))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//}
