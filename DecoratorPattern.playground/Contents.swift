//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


//Interface/ Abstract/ general class of Beverage
protocol Beverage {
    var description: String {get set}
    var size: String {get set}

    func getDescription() -> String
   
    func cost() -> Double
    
    func getSize() -> String
    
    func setSize()
}

//General/Abstract class of Condiment/Decorator (subclass of Beverage/Subject)
class Condiments: Beverage {
    
    var size: String = ""
    var description: String = ""
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 0.0
    }
    
    func getSize() -> String {
        return size
    }
    
    func setSize() {
        return
    }
}

//Specific/ Concrete beverage class
class Espresso: Beverage {
    var size: String = "tall"
    var description: String = "Normal Espresso"
    var sizeOnInterface: String = "grande"
    
    func setSize() {
        self.size = sizeOnInterface
        self.description = "\(size) Expresso"
    }
    
    func getSize() -> String {
        return size
    }
    
   
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 1.99
    }
}

class HouseBlend: Beverage {
    var size: String = "tall"
    var description: String = "House Blend Coffee"
    var sizeOnInterface: String = "grande"
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 0.89
    }
    
    func getSize() -> String {
        return size
    }
    
    func setSize() {
        self.size = sizeOnInterface
    }
}

class Viva: Beverage {
    var size: String = "tall"
    var description: String = "Viva"
    var sizeOnInterface: String = "grande"
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 5
    }
    
    func getSize() -> String {
        return size
    }
    
    func setSize() {
        self.size = sizeOnInterface
    }
}

//Specific/ Concrete class of Condiment
class Mocha: Condiments {
    //decorating object/ subject
    let beverage: Beverage!
    
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "\(beverage.getDescription()), Mocha"
    }
    
    override func cost() -> Double {
        return (0.2 + beverage.cost())
    }
    
}

class Soy: Condiments {
    let beverage: Beverage!
    
    init(beverage: Beverage) {
        self.beverage = beverage
        super.init()
        self.size = beverage.getSize()
    }
    
    override func getDescription() -> String {
        return "\(beverage.getDescription()), Soy"
    }
    
    override func cost() -> Double
    {
        if self.size == "tall" {
             return (0.15 + beverage.cost() + 0.1)
        } else if self.size == "grande" {
            return (0.15 + beverage.cost() + 0.15)
        } else {
             return (0.15 + beverage.cost() + 0.2)
        }
    }
}

class Whip: Condiments {
    let beverage: Beverage!
    
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "\(beverage.getDescription()), Whip"
    }
    
    override func cost() -> Double {
        return (0.1 + beverage.cost())
    }
}


let beverage: Beverage = Viva()
beverage.cost()

var beverage2: Beverage = Viva()
beverage2 = Mocha(beverage: beverage2)
beverage2 = Mocha(beverage: beverage2)
beverage2 = Whip(beverage: beverage2)
beverage2.cost()
beverage2.getDescription()

var coffee: Beverage = HouseBlend()
coffee = Mocha(beverage: coffee)
coffee = Mocha(beverage: coffee)

coffee.getDescription()
coffee.cost()


var expresso: Beverage = Espresso() //expresso chua co Mocha
expresso.setSize()

expresso = Soy(beverage: expresso)

expresso.cost()

