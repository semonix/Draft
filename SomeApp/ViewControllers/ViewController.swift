import UIKit

class ViewController: UIViewController {

    /// Загрузка View
    override func loadView() {
        super.loadView()
        
        // Создает view контроллера
        // Если вы хотите создать view программно без использования xib или storyboard,
        // переопределите этот метод и присвойте свой кастомный view свойству self.view.
        // В там случае не надо вызывать super.loadView()
            
//        let view = UIView()
//        view.backgroundColor = .cyan
//        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Вызывается после загрузки view в память
        // Здесь view уже создана, но еще не отображена на экране
        // Подходит для начальной настройки UI, добавления жестов и т.д.
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        
        // Загружает view, только если она еще не загружена
        // Полезно для обеспечения того, чтобы view было загружено перед выполнением определенных действий.
        // Может быть вызван вручную для принудительной загрузки view
        // Не вызывается автоматически в жизненном цикле
    }
    /// Отображение View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Вызывается перед тем, как view станет видимой
        // Хорошо подходит для обновления UI перед показом
        // Хорошее место для запуска анимаций или обновления данных
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        // добавлен в iOS 17, поддерживается с ios 13
        // Вызывается когда view уже видна, но переход еще не завершен
        // Размеры view уже финальные, в отличие от viewWillAppear
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Может вызываться многократно (при повороте экрана, изменении размеров и т.д.)
        // Хорошее место для обновления constraints или размеров перед layout
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Хорошее место для финальных корректировок размеров или позиционирования
        // Здесь subviews уже имеют свои финальные размеры и позиции
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Вызывается после того, как view полностью отобразилась
        // Хорошее место для операций, требующих видимой view
        // Например, запуск анимаций, воспроизведение видео, загрузка данных или запуск дорогих операций
    }
    
    /// Скрытие View
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Вызывается перед тем, как view будет скрыта
        // Хорошее место для сохранения данных, остановки анимаций
        // Рекомендуется отменять сетевые запросы или отписываться от уведомлений
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Хорошее место для освобождения ресурсов, остановки таймеров
        // Можно очистить кэш или снизить использование памяти
    }
    
    /// Очистка ресурсов:
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Вызывается при нехватке памяти в системе
        // Рекомендуется освободить ненужные ресурсы
        // Например, очистить кэши изображений, отменить операции
    }
    
    deinit {
        // Вызывается при удалении контроллера из памяти
        // Последний шанс на освобождение ресурсов или отмену подписок. Или остановить таймеры, закрыть соединения.
        // Здесь необходимо освободить все сильные ссылки
        // Например, отписаться от NotificationCenter, остановить таймеры
    }
}
//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: ViewController())
//}
