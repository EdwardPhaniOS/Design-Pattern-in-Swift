import UIKit
import PlaygroundSupport


//MARK: - Model

class Cat {
    enum Rarity {
        case common
        case uncommon
        case rare
        case veryRare
    }
    
    let name: String
    let birthday: Date
    let rarity: Rarity
    
    init(name: String, birthday: Date, rarity: Rarity) {
        self.name = name
        self.birthday = birthday
        self.rarity = rarity
    }
}

// MARK: - View Model

class CatViewModel {
    let cat: Cat
    let calendar: Calendar
    
    init(cat: Cat) {
        self.cat = cat
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    var name: String {
        return cat.name
    }
    
    var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: cat.birthday)
        let compoments = calendar.dateComponents([.year], from: birthday, to: today)
        
        let age = compoments.year!
        return "\(age) years old"
    }
    
    var adoptionFee: String {
        switch cat.rarity {
        case .common:
            return "$50"
        case .uncommon:
            return "$75"
        case .rare:
            return "$150"
        case .veryRare:
            return "$500"
        }
    }
}

extension CatViewModel {
    func configure(_ view: CatView) {
        view.nameLabel.text = self.name
        view.ageLabel.text = self.ageText
        view.adoptionFeeLabel.text = self.adoptionFee
    }
}


// MARK: - View
//Khi doi tuong B chua co tren bo nho (chua duoc khoi tao) thi doi tuong A khong the ke thua tu B
class CatView: UIView {
    let nameLabel: UILabel
    let ageLabel: UILabel
    let adoptionFeeLabel: UILabel
    
    override init(frame: CGRect) {
        var childFrame = CGRect(x: 0, y: 16, width: frame.width, height: frame.height / 2)
        
        childFrame.origin.y += childFrame.height + 16
        childFrame.size.height = 30
        nameLabel = UILabel(frame: childFrame)
        nameLabel.textAlignment = .center
        
        childFrame.origin.y += childFrame.height
        ageLabel = UILabel(frame: childFrame)
        ageLabel.textAlignment = .center
        
        childFrame.origin.y += childFrame.height
        adoptionFeeLabel = UILabel(frame: childFrame)
        adoptionFeeLabel.textAlignment = .center
        
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(adoptionFeeLabel)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder: ) is not supported")
    }
}


// MARK: - Example

let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
let omaniCat = Cat(name: "Omani", birthday: birthday, rarity: .veryRare)

let viewModel = CatViewModel(cat: omaniCat)

let frame = CGRect(x: 0, y: 0, width: 300, height: 420)
let catView = CatView(frame: frame)

// Cach 1
viewModel.configure(catView)

// Cach 2
catView.nameLabel.text = viewModel.name
catView.ageLabel.text = viewModel.ageText
catView.adoptionFeeLabel.text = viewModel.adoptionFee

PlaygroundPage.current.liveView = catView


