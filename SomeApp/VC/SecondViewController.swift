import UIKit

class SecondViewController: UIViewController {
    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "vc 2"
        view.backgroundColor = .gray
        initImage()
        loadPhoto()
//        let imageURL = URL(string:         "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//        if let data = try? Data(contentsOf: imageURL) {
//            imageView.image = UIImage(data: data)
//        }
    }
    func initImage() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
    }

    func loadPhoto() {
        let queue = DispatchQueue.global(qos: .utility)
        let imageURL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
        queue.async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    deinit {
        print("SecondViewController is deinit")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
