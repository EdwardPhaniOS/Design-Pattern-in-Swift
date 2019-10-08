import UIKit
import Foundation
var str = "Hello, playground"


class Pizza
{
    var name: String = "default pizza"
    var dough: String = "default dough"
    var sauce: String = "defualt sause"
    var toppings: [String] = []
    
    func prepare()
    {
        print("Preparing \(name)")
        print("Tossing dough...")
        print("Adding sauce...")
        print("Adding toppings:")
        
        if toppings.count > 0 {
            for i in 0...(toppings.count - 1)
            {
                print("\t \(toppings[i])")
            }
        }
    }
    
    func bake()
    {
        print("Bake for 25 minutes at 350")
    }
    
    func cut()
    {
        print("Cutting the pizza into diagonal slices")
    }
    
    func box()
    {
        print("Place pizza in official PizzaStore box")
    }
    
    func getName() -> String {
        return name
    }
}

let defaultPizza = Pizza()
defaultPizza.prepare()

class NYStyleCheesePizza: Pizza {
    override init() {
        super.init()
        
        self.name = "NY Style Sauce and Cheese Pizza"
        self.dough = "Thin Crust Dough"
        self.sauce = "Marinara Sauce"
        self.toppings.append("Grated Reggiano Cheese")
    }
}

let NYPizza = NYStyleCheesePizza()
NYPizza.prepare()

class ChicagoStyleCheesePizza: Pizza {
    override init() {
        super.init()
        
        self.name = "Chicago Style Deep Dish Cheese Pizza"
        self.dough = "Extra Thick Crust Dough"
        self.sauce = "Plum Tomato Sauce"
        self.toppings.append("Grated Reggiano Cheese")
    }
    
    override func cut() {
        print("Cutting the pizza into square slices")
    }
}

let CGPizza = ChicagoStyleCheesePizza()
CGPizza.prepare()
CGPizza.cut()


protocol PizzaStore: class
{
    func createPizza()
    
    func orderPizza() -> Pizza
}

class NYPizzaStore: PizzaStore
{
    let nyPizza: Pizza
    
    //default NYPizza
    init()
    {
        self.nyPizza = NYStyleCheesePizza()
    }
    
    func createPizza() {
        nyPizza.prepare()
        nyPizza.bake()
        nyPizza.cut()
        nyPizza.box()
    }
    
    func orderPizza() -> Pizza {
        createPizza()
        return nyPizza
    }
}

class CGPizzaStore: PizzaStore
{
    let cgPizza: Pizza
    
    //default CGPizza
    init()
    {
        self.cgPizza = ChicagoStyleCheesePizza()
    }
    
    func createPizza() {
        cgPizza.prepare()
        cgPizza.bake()
        cgPizza.cut()
        cgPizza.box()
    }
    
    func orderPizza() -> Pizza {
        createPizza()
        return cgPizza
    }
}

let nyStore = NYPizzaStore()
let cgStore = CGPizzaStore()
var pizza = nyStore.orderPizza()
print("Ethan ordered a \(pizza.getName())")

pizza = cgStore.orderPizza()
print("Joel ordered a \(pizza.getName())")
