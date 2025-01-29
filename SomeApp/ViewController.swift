import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let defaults = UserDefaults.standard
    let keyForTheme = "theme"
    let keyForFontSize = "fontSize"
    let oldThemeKey = "oldThemeKey"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviewsAndLayout()
        
//        Регистрируй дефолтные настройкинастройки:
//        - Зарегистрируй «фабричные» значения для
//        некоего набора ключей. Например, "theme":
//        "light", "fontSize": 14.
        defaults.set("light", forKey: keyForTheme)
        defaults.set(14, forKey: keyForFontSize)
        
        if "light" == defaults.string(forKey: keyForTheme) {
            print("Значение \"light\" удачно записалось под ключом \(keyForTheme)")
        }
        if 14 == defaults.integer(forKey: keyForFontSize) {
            print("Значение 14 удачно записалось под ключом \(keyForFontSize)")
        }
        
//        Создай условие миграции старого ключа на
//    новый:
//        У тебя есть «устаревший» ключ "oldThemeKey".
//        Если по нему что-то есть, перенеси это
//        значение в "theme" и удали старый ключ.
        if let oldValue = defaults.string(forKey: oldThemeKey) {
            defaults.set(oldValue, forKey: keyForTheme)
            defaults.removeObject(forKey: oldThemeKey)
        }

        
//        Внеси обновление одной из настроек, допустим,
//        "theme": "dark", чтобы показать, как её можно
//        изменить.
        defaults.set("dark", forKey: keyForTheme)
        
//        Выведи все ключи-значения через
//        dictionaryRepresentation()
        showAllKeysAndValues()
        print("/*---------------------------------------------------------------------*/")
//        Удаляй, по желанию, один из ключей и покажи
//        результат удаления, вновь распечатай данные.
        defaults.removeObject(forKey: keyForTheme)
        showAllKeysAndValues()
        
        customizeAppearance()
    }
    func showAllKeysAndValues() {
        let allValues = defaults.dictionaryRepresentation()
        allValues.forEach { key, value in
            print("VALUE:")
            print("\(key): \(value)")
        }
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
    }
}

@available(iOS 17.0, *)
#Preview {
//    UINavigationController(rootViewController: ViewController())
    ViewController()
}
