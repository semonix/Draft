import UIKit
import SnapKit
// MARK: - FOODCELL
class FoodCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        // Очищаем слои при переиспользовании
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        backgroundColor = nil
    }

    func applyGradient(_ colors: [CGColor], frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.colors = colors
        gradient.frame = frame
        layer.insertSublayer(gradient, at: 0)
    }
}
// MARK: - FOODCONTROLLER
class FoodController: UICollectionViewController {
    
    private let backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
    private let firstSectionColorPartOne = UIColor(red: 255.0/255.0, green: 27.0/255.0, blue: 9.0/255.0, alpha: 1)
    private let firstSectionColorPartTwo = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 228.0/255.0, alpha: 1)
    private lazy var gradientLayerForVCofFirstSection: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.colors = [firstSectionColorPartOne.cgColor,
                                firstSectionColorPartOne.cgColor,
                                firstSectionColorPartTwo.cgColor,
                                firstSectionColorPartTwo.cgColor]
        return gradientLayer
    }()
    private let secondSectionColor = UIColor.white
    private let thirdSectionColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 142.0/255.0, alpha: 1)
    private let fourthSectionColor = UIColor.white
    private let cellId = "cellId"
    private let headerId = "headerId"
    private static let categoryHeaderId = "categoryHeaderId"
    
    // MARK: - LAYOUT
    /// Создаём layout (расположение ячеек) и передаём его в родительский класс
    init() {
        super.init(collectionViewLayout: Self.createLayout())
    }
    private static func createLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                // MARK: - FIRST SECTION
            case 0:
                let item  = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(200)
                ), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
                // MARK: - SECOND SECTION
            case 1:
                let item  = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(0.25),
                    heightDimension: .absolute(150)))
                item.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(500)
                ), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 16)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ), elementKind: categoryHeaderId, alignment: .topLeading)]
                return section
                // MARK: - THIRD SECTION
            case 2:
                let item  = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(125)
                ), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
                // MARK: - FOURTH SECTION
            case 3:
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .absolute(250)))
                item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(1000)
                ), subitems: [item])
                                                               
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 32, leading: 8, bottom: 8, trailing: 8)
//                section.orthogonalScrollingBehavior = .
                return section
            default:
                return nil
            }
        }
    }
    // MARK: - HEADERS AND COUNT
    
    /// HEADERS
    /// Указываем, какой индентификатор использовать для заголовка
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
//        header.backgroundColor = .systemBlue
        return header
    }
    /// COUNT
    /// Количество секций
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    /// Количество ячеек в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: 3
        case 1: 8
        case 2: 3
        case 3: 5
        default: 0
        }
    }
    // MARK: - CELL APPEARANCE
    /// Возвращает готовую ячейку для отображения на экране
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// Извлекаем переиспользуемую ячейку по заранее зарегистрированному идентификатору
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FoodCell

        switch indexPath.section {
        case 0:
            cell.applyGradient([
                firstSectionColorPartOne.cgColor,
                firstSectionColorPartOne.cgColor,
                firstSectionColorPartTwo.cgColor,
                firstSectionColorPartTwo.cgColor
            ], frame: cell.bounds)
        case 1:
            cell.backgroundColor = secondSectionColor
        case 2:
            cell.backgroundColor = thirdSectionColor
        case 3:
            cell.backgroundColor = fourthSectionColor
        default:
            cell.backgroundColor = .black
        }
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = backgroundColor
        navigationItem.title = "Food Delivery"
        /// Регистрируем тип ячейки для возможности её переиспользования
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: cellId)
        /// Регистрируем тип заголовка для возможности его переиспользования
        collectionView.register(Header.self, forSupplementaryViewOfKind: Self.categoryHeaderId, withReuseIdentifier: headerId)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - ACTION
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let section = indexPath.section
        print("item: \(item), section: \(section)")
        
        let viewController = UIViewController()
        switch section {
        case 0:
            gradientLayerForVCofFirstSection.frame = viewController.view.bounds
            viewController.view.layer.insertSublayer(gradientLayerForVCofFirstSection, at: 0)
        case 1:
            viewController.view.backgroundColor = secondSectionColor
        case 2:
            viewController.view.backgroundColor = thirdSectionColor
        case 3:
            viewController.view.backgroundColor = fourthSectionColor
        default:
            break
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
// MARK: - CLASS HEADER
class Header: UICollectionReusableView {
    
    var label = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        label = .init(frame: .zero)
//        label.font = .systemFont(ofSize: 17, weight: .bold)
//        label.textAlignment = .center
        label.text = "Categories"
        addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: FoodController())
}
