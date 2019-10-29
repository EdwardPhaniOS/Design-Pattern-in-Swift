import Foundation



// MARK: - Dependencies

struct Customer {
    let identifier: String
    var address: String
    var name: String
}

extension Customer: Hashable {
    
    var hashValue: Int {
        return identifier.hashValue
    }
    
    static func ==(lhs: Customer, rhs: Customer) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}

struct Product {
    let identifier: String
    var name: String
    var cost: Double
}

extension Product: Hashable {
    
    var hashValue: Int {
        return identifier.hashValue
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
}

class InventoryDatabase {
    var inventory: [Product : Int] = [:]

    init(inventory: [Product : Int]) {
        self.inventory = inventory
    }
}

class ShippingDatabase {
    var pendingShipment: [Customer : [Product]] = [:]
}
