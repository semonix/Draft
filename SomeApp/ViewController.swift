import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let keyForUDS = "counterKey"
    let keyForKeychain = "keyForKeychain"
    let uds = UserDefaults.standard
    var counter = 0
    var password = " No password. "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviewsAndLayout()
        
//        counter = uds.integer(forKey: keyForUDS)
//        counter += 1
//        uds.set(counter, forKey: keyForUDS)
        
        if let previouslySavedPassword = readFromKeychain(forKey: keyForKeychain) {
            // Если пароль ранее был сохранен
            password = previouslySavedPassword
        } else {
            // Если пароль отсутствует
            _ = saveToKeychain(value: "newPassword", forKey: keyForKeychain)
        }
        
        customizeAppearance()
    }
    func addSubviewsAndLayout() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }

    }
    func customizeAppearance() {
//        view.backgroundColor = .black
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        
        if counter != 0 {
            label.text = String(counter)
        } else {
            label.text = password
        }
    }
}
// MARK: - KeyChain
extension ViewController {
    func saveToKeychain(value: String, forKey key: String) -> Bool {
        // Преобразуем строку в Data
        guard let valueData = value.data(using: .utf8) else {
            return false
        }
        // Создаем словарь с параметрами для записи
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: valueData
        ]
        
        // Удаляем предыдущий элемент с таким же ключом (если существует)
        SecItemDelete(query as CFDictionary)
        
        // Добавляем новый элемент в Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Ошибка сохранения в Keychain: \(status)")
        }
        
        // Проверяем результат операции
        return status == errSecSuccess
    }
    func readFromKeychain(forKey key: String) -> String? {
        // Создаем словарь с параметрами для поиска
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?

        // Ищем элемент в Keychain
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data,
               let value = String(data: retrievedData, encoding: .utf8) {
                return value
            }
        }
        return nil
    }
}

@available(iOS 17.0, *)
#Preview {
//    UINavigationController(rootViewController: ViewController())
    ViewController()
}
