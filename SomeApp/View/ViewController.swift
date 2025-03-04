import UIKit
import Alamofire

struct GetRequest: Decodable {
    let data: [Data]
}
struct Data: Decodable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
}
struct Person: Decodable {
    let id: String
    let name: String
    let createdAt: String
}
class ViewController: UITableViewController {
    private let service = NetworkService.shared
    private let url = URL(string: "https://reqres.in/api/users")!
    var people: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButton()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        downloadData()
    }
    func downloadData() {
          /// Код для использования c файлом NetworkService
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
        
        /// Код для использования c файлом NetworkService+Error
//        service.fetchData(url: url) { (result: Result<GetRequest, NetworkError>) in
//            switch result {
//            case .success(let success):
//                self.people = success.data
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let failure):
//                DispatchQueue.main.async {
//                    switch failure {
//                    case .badData:
//                        self.showError(description: "Ваши данные плохие")
//                    case .badResponse:
//                        self.showError(description: "Ответ плох...")
//                    case .badRequest:
//                        self.showError(description: "С запросом точно всё ок?")
//                    case .badDecode:
//                        self.showError(description: "Не удалось декодировать")
//                    case .unknown(let description):
//                        self.showError(description: description)
//                    }
//                }
//            }
//        }
        
        /// Код для использования c файлом NetworkService+Method
        service.fetchData(url: url, httpMethod: .get) { (result: Result<GetRequest, NetworkError>) in
            switch result {
            case .success(let success):
                self.people = success.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    switch failure {
                    case .badData:
                        self.showError(description: "Ваши данные плохие")
                    case .badResponse:
                        self.showError(description: "Ответ плох...")
                    case .badRequest:
                        self.showError(description: "С запросом точно всё ок?")
                    case .badDecode:
                        self.showError(description: "Не удалось декодировать")
                    case .unknown(let description):
                        self.showError(description: description)
                    case .badEncode:
                        self.showError(description: "Не удалось отправить...")
                    }
                }
            }
        }

        /// Код для использования c Alamofire
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        
//        AF.request(url, method: .get)
//        .validate()
//        .responseDecodable(of: GetRequest.self, queue: DispatchQueue.global(), decoder: decoder) { response in
//            switch response.result {
//            case .success(let success):
//                self.people = success.data
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
    }

    // MARK: - TABLE VIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = people[indexPath.row].firstName
        cell.contentConfiguration = content
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    func setupNavigationBarButton() {
        let button = UIBarButtonItem(title: "Добавить человека!",
                                     style: .plain,
                                     target: self,
                                     action: #selector(buttonTapped)
        )
        navigationItem.rightBarButtonItem = button
    }
    @objc func buttonTapped() {
        print("Кнопка нажата")
        showCustomAlert()
    }
}
// MARK: - SHOW ERROR
private extension ViewController {
    func showError(description: String? = nil) {
        let alert = UIAlertController(title: "Произошла ошибка", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default))
        present(alert, animated: true)
    }
}
// MARK: - SETUP PERSON
private extension ViewController {
    func showCustomAlert() {
        /// Создание UIAlertController
        let alert = UIAlertController(title: "Введите данные", message: nil, preferredStyle: .alert)
        /// Добавление первого текстового поля
        alert.addTextField { textField in
            textField.placeholder = "Введите имя"
        }
        /// Добавление кнопки действия
        let submitAction = UIAlertAction(title: "Отправить post request", style: .default) { [unowned alert] _ in
            /// Получение значений из текстовых полей
            let firstValue = alert.textFields![0].text
            self.addPerson(name: firstValue ?? "")
        }
        /// Добавление действия в алерт
        alert.addAction(submitAction)
        
        /// Отображение алерта
        present(alert, animated: true)
    }
    func addPerson(name: String) {
//        service.fetchData(
//            url: url,
//            httpMethod: .post,
//            body: ["name" : name]
//        ) { (result: Result<Person, NetworkError>) in
//            switch result {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    self.showNewPerson(from: success)
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        let param: Parameters = ["name": name]
        
        AF.request(url, method: .post, parameters: param)
            .validate()
            .responseDecodable(of: Person.self) { response in
                switch response.result {
                case .success(let success):
                    self.showNewPerson(from: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
    func showNewPerson(from person: Person) {
        let alert = UIAlertController(
            title: "Ваше имя: \(person.name)",
            message: "Создано: \(person.createdAt)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
    //    ViewController()
}

