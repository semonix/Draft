import UIKit

struct Posts: Decodable {
    let id: Int
    let title: String
}

class ViewController2: UITableViewController {

    private var posts: [Posts] = []
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .gray
        downloadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func downloadData() {
        guard let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/posts") else { return }
        
        // Используем NetworkService для получения данных
        networkService.fetchData(url: url) { (result: Result<[Posts], Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.posts = data
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error downloading dara:", error)
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = posts[indexPath.row].title
        cell.contentConfiguration = content
        
        return cell
    }
    
    deinit {
        print("=ABOBA=")
    }
}

class NetworkService {
    // Этот метод получает данные из сети и декодирует их в указанный тип модели
    func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        print(0)
        // Создаём задачу для получения данных
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Убеждаемся, что получены данные и нет ошибки
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
//            sleep(5)
            self.showData(from: data)
            
            // Пытаемся декодировать данные
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func showData(from data: Data) {
        print("Ваши данные - это: \(data.count)")
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: ViewController2())
//}
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
    //    ViewController()
}
