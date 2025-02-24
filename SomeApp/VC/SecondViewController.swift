import UIKit

class Canceled {}

class SecondViewController: UIViewController {
    let label = UILabel()
    var canceled: Canceled? = Canceled()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        setupAppearance()
        setupTargets()

        //        DispatchQueue.global(qos: .utility).async {
//            DispatchQueue.concurrentPerform(iterations: 20_000) {
//                print("""
//                      \($0) times
//                      \(String(validatingCString: __dispatch_queue_get_label(nil))!)
//                      \(Thread.current)
//                      """)
//            }
//        }
        
        
        
//        myInactiveQueue()
        
        var canceled2 = canceled
        canceled = nil
        
        Task { [weak canceled] in
            for i in 1...50 {
                try? await Task.sleep(nanoseconds: 1 * 1_00_000_000) // задержка в 0.1 секунды
                
                if canceled != nil {
                    print(i)
                } else {
                    print("(\(i)) canceled == nil")
                }
            }
        }

        // Отменяем задачу выше через 3 секунды
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            canceled = nil
        }
    }
    deinit {
        print("SecondViewController is deinit")
    }
}
// MARK: - EXAMPLE OF GCD
extension SecondViewController {
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "The Swift Dev", attributes: [.concurrent, .initiallyInactive])

        inactiveQueue.async {
            print("Done!")
        }
        print("Not yet started...")
        // Активирует очередь, созданную с атрибутом .initiallyInactive. После этого очередь начинает выполнять задачи.
        inactiveQueue.activate()
        print("Activate!")
        
//        suspend()/resume() работают через счетчик приостановок (например, два suspend() требуют двух resume()). Не имеют отношения к .initiallyInactive — работает с любой очередью

        // блокирует новые задачи
        inactiveQueue.suspend()
        
        print("Pause!")
        
        // Возобновляет выполнение новых задач в очереди (после suspend())
        inactiveQueue.resume()
    }
}
// MARK: - SETUP
extension SecondViewController {
    func addSubviews() {
        view.addSubview(label)
    }
    
    func setupLayout() {
        label.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    
    func setupAppearance() {
        label.text = "Hello"
        label.font = .systemFont(ofSize: 37)
        label.textAlignment = .center
        label.layer.borderWidth = 1
    }
    
    func setupTargets() {
        
    }
    
//    @objc func buttonPressed() {
//    }

}


@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: SecondViewController())
//    UINavigationController(rootViewController: MyViewController())
}
