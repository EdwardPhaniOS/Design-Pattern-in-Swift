import UIKit

var str = "Hello, playground"


//MARK: - Product

struct HotPot {
    let meat: Meat
    let vegetables: Vegetables
}

extension HotPot: CustomStringConvertible {
    var description: String {
        return meat.rawValue + " hot pot"
    }
}

enum Meat: String {
    case beef
    case chicken
    case kitten
    case tofu
}

struct Vegetables: OptionSet {
    static let cabbage = Vegetables(rawValue: 1 << 0)
    static let carrot = Vegetables(rawValue: 1 << 1)
    static let cucumber = Vegetables(rawValue: 1 << 2)
    static let corn = Vegetables(rawValue: 1 << 3)
    
    let rawValue: Int
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}


//MARK: - Builder
class HotPotBuilder {
    
    enum Error: Swift.Error {
        case soldOut
    }
    
    private(set) var meat: Meat = .beef
    private(set) var vegetable: Vegetables = []
    private var soldOutMeat: [Meat] = [.kitten]
    
    func addVegetable(_ vegetable: Vegetables) {
        self.vegetable.insert(vegetable)
    }
    
    func removeVegetable(_ vegetable: Vegetables) {
        self.vegetable.remove(vegetable)
    }
    
    func setMeat(_ meat: Meat) throws {
        guard isAvailable(meat) else {
            throw Error.soldOut
        }
        
        self.meat = meat
    }
    
    func isAvailable(_ meat: Meat) -> Bool {
        return !soldOutMeat.contains(meat)
    }
    
    func build() -> HotPot {
        return HotPot(meat: meat, vegetables: vegetable)
    }
}

//MARK: - Director
class Employee {
    
    func createCombo1() throws -> HotPot {
        let builder = HotPotBuilder()
        try builder.setMeat(.beef)
        builder.addVegetable(.cabbage)
        builder.addVegetable(.carrot)
        return builder.build()
    }
    
    func createKittenSpecial() throws -> HotPot {
        let builder = HotPotBuilder()
        try builder.setMeat(.kitten)
        builder.addVegetable(.cucumber)
        builder.addVegetable(.carrot)
        return builder.build()
    }
}

//MARK: - Example
let employee = Employee()

if let combo1 = try? employee.createCombo1() {
    print(combo1.description)
}

if let kittenSpecial = try? employee.createKittenSpecial() {
    print(kittenSpecial.description)
} else {
    print("Sorry, no kitten hot pot here")
}

do {
    try employee.createKittenSpecial()
} catch let error {
    print("error: \(error)")
}

