import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var shouldPrintToConsole = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Используйте этот метод, чтобы опционально настроить и прикрепить UIWindow `window` к предоставленной UIWindowScene `scene`.
        // Если используется раскадровка, свойство `window` будет автоматически инициализировано и прикреплено к сцене.
        // Этот делегат не подразумевает, что подключаемая сцена или сессия являются новыми (вместо этого смотрите `application:configurationForConnectingSceneSession`).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window!.makeKeyAndVisible()
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Вызывается, когда сцена освобождается системой.
        // Это происходит вскоре после выхода сцены в фон или когда ее сессия отбрасывается.
        // Освободите все ресурсы, связанные с этой сценой, которые могут быть созданы заново при следующем подключении сцены.
        // Сцена может подключиться позже, так как ее сессия не обязательно была отменена (см. `application:didDiscardSceneSessions` вместо этого).
        
        if shouldPrintToConsole {
            print(#function, "- scene did terminate")
        }
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена перешла из неактивного состояния в активное.
        // Используйте этот метод для перезапуска всех задач, которые были приостановлены (или еще не запущены), когда сцена была неактивна.
        
        if shouldPrintToConsole {
            print(#function, "- Active now")
        }
    }
    func sceneWillResignActive(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из активного состояния в неактивное.
        // Это может произойти из-за временных прерываний (например, входящего телефонного звонка).
        
        if shouldPrintToConsole {
            print(#function, "- Inactive now")
        }
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Вызывается при переходе сцены с фона на передний план.
        // Используйте этот метод, чтобы отменить изменения, сделанные при переходе на задний план.
        
        if shouldPrintToConsole {
            print(#function, "- Will be Active")
        }
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Вызывается при переходе сцены с переднего плана на задний.
        // Используйте этот метод, чтобы сохранить данные, освободить общие ресурсы и сохранить достаточно информации о состоянии сцены,
        // чтобы вернуть ее в текущее состояние.
        
        if shouldPrintToConsole {
            print(#function, "- Background now")
        }
    }
}

