import UIKit

class SecondViewController: UIViewController {
    let label = UILabel()
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
        myInactiveQueue()
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
        
        // Возобновляет выполнение новых задач в очереди
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
