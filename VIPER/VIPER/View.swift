import UIKit
import SnapKit


// ViewController
// protocol
// reference to presenter

protocol AnyView: AnyObject {
    
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}
class UserViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()	
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.label.isHidden = true
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    func update(with error: String) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.label.text = error
            self.label.isHidden = false
        }
        print(1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print(2)
            self.presenter?.switchToAnotherScreen()
        }
    }
    deinit {
        print("View deinitialized")
    }
}
extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = UIListContentConfiguration.cell()
        
        let row = indexPath.row
        let userName = users[row].name
        
        content.text = userName
        cell.contentConfiguration = content
        
        return cell
    }
}
