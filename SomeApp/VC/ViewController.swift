import UIKit

struct Person: Decodable {
    let id: Int
    let name: String
}
class ViewController: UITableViewController {
    
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func downloadData() {
        guard let url = URL(string: "https://mocki.io/v1/1ea7c719-336e-4aae-bd11-06bca6c06ede") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                print("Error downloading data:", error ?? "Unknown error")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Person].self, from: data)
                DispatchQueue.main.async {
                    self.people = decodedData
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding data:", error)
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = people[indexPath.row].name
        cell.contentConfiguration = content
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetail()
    }
    func showDetail() {
        navigationController?.pushViewController(ViewController2(), animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
    //    ViewController()
}

