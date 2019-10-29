//import UIKit

var str = "Hello, playground"

//** PROTOCOL IN SWIFT**
protocol Payable{
    func pay() -> (base: Double, bonus: Double)
}

class Employee {
    var name: String
    var type: String //hourly or salary
    
    init(name: String, type: String) {
        self.name = name
        self.type = type
    }
    
}

class HourlyEmployee : Employee, Payable
{
    var hourlyWage = 15.0
    var hoursWork = 10.0
    
    func pay() -> (base: Double, bonus: Double) {
        return (hourlyWage * hoursWork, 0)
    }
}

class SalaryEmployee: Employee, Payable
{
    var salary = 100000.0
    func pay() -> (base: Double, bonus: Double) {
        return (salary, 0.1 * salary)
    }
}

let sam = HourlyEmployee(name: "Sam", type: "Hourly")
sam.hourlyWage = 20.0
sam.hoursWork = 19.0
sam.pay()

let genericEmployee = Employee(name: "ABC", type: "unknown")
genericEmployee.name

let hourlyEmployeeA = SalaryEmployee(name: "SJob", type: "Hourly")
hourlyEmployeeA.pay()

//** DELEGATE PATTERN IN SWIFT**

//Delegate Protocol
protocol AdvancedLifeSupport {
    func performCPR()
}

//Object need a delegate
class EmergencyCallHandler {
    
    var delegate: AdvancedLifeSupport?
    
    func assessSituation() {
        print("Can you tell me what happened?")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
}

class Paramedic: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic perform CPR")
    }
}

class Doctor: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The doctor perform CPR")
    }
    
    func useStethescope() {
        print("Listening for heart sound")
    }
}

class Surgeon: Doctor {
    
    override func performCPR() {
        print("The surgeon perform CPR")
    }
    
}

let emily = EmergencyCallHandler()
let jack = Paramedic(handler: emily)
let peter = Doctor(handler: emily)
let ketn = Surgeon(handler: emily)

emily.assessSituation()
emily.medicalEmergency()



