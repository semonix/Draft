import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var shouldPrintToConsole = false
    // UI элементы
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        
        // Создает view контроллера
        // Если вы хотите создать view программно без использования xib или storyboard,
        // переопределите этот метод и присвойте свой кастомный view свойству self.view.
        // В там случае не надо вызывать super.loadView()
        
        // Создаем основной view контроллера
        view = UIView()
        view.backgroundColor = .systemMint
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Вызывается после загрузки view в память
        // Здесь view уже создана, но еще не отображена на экране
        // Подходит для начальной настройки UI, добавления жестов и т.д.
        // Но размеры элементов ещё не окончательны

        // Начальная настройка UI и данных
        setupUI()
        configureConstraints()
        fetchInitialData()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        
        // Загружает view, только если она еще не загружена
        // Полезно для обеспечения того, чтобы view было загружено перед выполнением определенных действий.
        // Может быть вызван вручную для принудительной загрузки view
        // Не вызывается при первом показа view, но вызывается после перехода от следующего view, к предыдущему (текущему) view
        
        if shouldPrintToConsole {
            print(#function)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Настройки перед появлением view на экране
        // Хорошо подходит для обновления UI перед показом
        // Хорошее место для подготовки приветственной анимации или обновления данных
        // Уже известны широта и высота объектов, но не их расположение

        updateUIState()
        registerForNotifications()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        // добавлен в iOS 17, поддерживается с ios 13
        // Вызывается когда view уже видна, но переход еще не завершен
        // Например, для прокрутки до определенной позиции в UIScrollView или UITableView.
        // Размеры view уже финальные, в отличие от viewWillAppear

        updateProgressIndicators()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Место для настройки после изменения ориентации
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Может вызываться многократно (при повороте экрана, изменении размеров и т.д.)
        // Хорошее место для обновления constraints или размеров перед layout

        updateDynamicContentSize()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Хорошее место для финальных корректировок размеров или позиционирования
        // Здесь subviews уже имеют свои финальные размеры и позиции

        adjustContentInsets()
        updateGradientLayers()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Вызывается после того, как view полностью отобразилась
        // Хорошее место для операций, требующих видимой view
        // Например, запуск анимаций, воспроизведение видео, загрузка данных или запуск дорогих операций
        // Операции, начатые в viewDidAppear(_:), должны быть остановлены или отменены в viewWillDisappear(_:) или viewDidDisappear(_:), если они больше не актуальны.

        startAnimations()
        logScreenView()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    /// Скрытие View
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Вызывается перед тем, как view будет скрыта, например при переходе другой VC
        // Хорошее место для сохранения данных, остановки анимаций
        // Рекомендуется отменять сетевые запросы или отписываться от уведомлений

        pauseAnimations()
        saveUserInput()
        unregisterFromNotifications()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Хорошее место для освобождения ресурсов, остановки таймеров, отслеживание геолокации, остановки сетевых запросов и других фоновых задач.
        // Можно очистить кэш или снизить использование памяти, отписаться от уведомлений или других событий

        cleanupResources()
        cancelPendingOperations()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Вызывается при нехватке памяти в системе
        // Рекомендуется освободить ненужные ресурсы
        // Например, очистить кэши изображений, отменить операции

        clearImageCache()
        removeUnusedViewControllers()
        
        if shouldPrintToConsole {
            print(#function)
        }
    }
    
    deinit {
        
        // Вызывается при удалении контроллера из памяти
        // Последний шанс на: освобождение ресурсов, отмену подписок, остановку таймеров и закрытия соединения
        // Здесь необходимо освободить все сильные ссылки
        // Например, отписаться от NotificationCenter, остановить таймеры
        
        NotificationCenter.default.removeObserver(self)
        print("ViewController deallocated")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        // Настройка UI элементов
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.text = "Заголовок экрана"
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Описание экрана и его функциональности"
        
        actionButton.setTitle("Нажми меня", for: .normal)
        actionButton.backgroundColor = .systemBlue
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 8
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        // Добавление элементов на view
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(actionButton)
    }
    
    private func configureConstraints() {
        // Настройка констрейнтов с SnapKit
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func actionButtonTapped() {
        print("Кнопка нажата")
        // Чтобы вызывались viewWillDisappear и viewDidDisappear, нужно перейти на другой VC:
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    // Методы, вызываемые в жизненном цикле
    private func fetchInitialData() {
        // Загрузка начальных данных
    }
    
    private func updateUIState() {
        // Обновление состояния UI
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification),
            name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        // Обработка уведомления
    }
    
    private func updateProgressIndicators() {
        // Обновление индикаторов прогресса
    }
    
    private func updateDynamicContentSize() {
        // Обновление размера динамического контента
    }
    
    private func adjustContentInsets() {
        // Настройка отступов контента
    }
    
    private func updateGradientLayers() {
        // Обновление градиентных слоев
    }
    
    private func startAnimations() {
        // Запуск анимаций
    }
    
    private func logScreenView() {
        // Логирование просмотра экрана (аналитика)
    }
    
    private func pauseAnimations() {
        // Приостановка анимаций
    }
    
    private func saveUserInput() {
        // Сохранение пользовательского ввода
    }
    
    private func unregisterFromNotifications() {
        NotificationCenter.default.removeObserver(self,
            name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func cleanupResources() {
        // Очистка ресурсов
    }
    
    private func cancelPendingOperations() {
        // Отмена ожидающих операций
    }
    
    private func clearImageCache() {
        // Очистка кэша изображений
    }
    
    private func removeUnusedViewControllers() {
        // Удаление неиспользуемых контроллеров
    }
}
