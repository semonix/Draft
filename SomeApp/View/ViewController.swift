import UIKit

struct GetRequest: Codable {
    let data: [Data]
}
struct Data: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
}
struct Person: Decodable {
    let id: Int
    let name: String
    let createdAt: String
}
class ViewController: UITableViewController {
    private let service = NetworkService()
    private let url = URL(string: "https://reqres.in/api/users")!
    var people: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButton()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        downloadData()
    }
    func downloadData() {
//        /// Код для использования c файлом NetworkService
//        service.fetchData(url: url) { (result: Result<GetRequest, Error>) in
//            switch result {
//            case .success(let success):
//                self.people = success.data
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//        let firstNames = ["Александр", "Мария", "Иван", "Екатерина", "Дмитрий", "Анна", "Сергей", "Ольга", "Никита", "Елена"]
//        let lastNames = ["Смирнов", "Иванова", "Кузнецов", "Петрова", "Соколов", "Морозова", "Попов", "Волкова", "Новиков", "Лебедева"]
//        let domains = ["mail.ru", "gmail.com", "yandex.ru", "outlook.com", "icloud.com"]
        service.fetchData(url: url) { (result: Result<GetRequest, NetworkError>) in
            switch result {
            case .success(let success):
                self.people = success.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    switch failure {
                    case .unknown(let description):
                        self.showError(description: description)
                    case .badData:
                        self.showError(description: "Ваши данные плохие")
                    case .badResponse:
                        self.showError(description: "Ответ плох...")
                    case .badRequest:
                        self.showError(description: "С запросом точно всё ок?")
                    case .badDecode:
                        self.showError(description: "Не удалось декодировать...")
                    }
                }
            }
        }
    }
    // MARK: - SHOW ERROR
    func showError(description: String) {
        //
    }
    // MARK: - ???
    func setupNavigationBarButton() {
        //
    }
    // MARK: - TABLE VIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let firstName = people[indexPath.row].firstName
        let lastName = people[indexPath.row].firstName
        content.text = firstName + " " + lastName
        cell.contentConfiguration = content
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    

}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
    //    ViewController()
}

