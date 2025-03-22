//
//  AppDelegate.swift
//  SomeApp
//
//  Created by Даниял on 28.01.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var shouldPrintToConsole = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Точка переопределения для настройки после запуска приложения.
        
        if shouldPrintToConsole {
            print(#function)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Вызывается при создании новой сессии сцены.
        // Используйте этот метод, чтобы выбрать конфигурацию для создания новой сцены.
        
        if shouldPrintToConsole {
            print(#function)
        }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Вызывается, когда пользователь отбрасывает сессию сцены.
        // Если какие-либо сессии были отброшены, пока приложение не было запущено, этот метод будет вызван вскоре после application:didFinishLaunchingWithOptions.
        // Используйте этот метод, чтобы освободить все ресурсы, которые были связаны с отброшенными сценами, так как они не вернутся.
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    func applicationWillTerminate(_ application: UIApplication) {
        if shouldPrintToConsole {
            print(#function, " - App will terminate")
        }
    }
}

