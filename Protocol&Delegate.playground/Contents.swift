//import UIKit

var str = "Hello, playground"

//Create Protocol: Create a set of rules, no concrete implementation
//Protocol: A set of rules

//Describes a set of rules, for example: A set of func with out specific implementation
//No concrete/ specific implementation (no "{..code...}")
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

//** DELEGATE IN SWIFT**

class UITableViewCell
{
    
}

protocol UITableViewDataSource {
    func numberOfRows(inSection section: Int) -> Int
    func tableView(cellForRowAt indexPath: Int) -> UITableViewCell
}

class UITableView
{
    var dataSource: UITableViewDataSource?
    
    private func setupTableViewCalledByTheSystem(inSection section: Int, at rowIndex: Int) {
        //secret, private implementation
        
        //at some random time, the system will call
        dataSource!.numberOfRows(inSection: section)
        dataSource?.tableView(cellForRowAt: rowIndex)
    }
}

//tableView = Me
//self - photoVC = Sam (My co-worker)
//data of photos = coffee (what I want)

class PhotosViewController : UITableViewDataSource {
    var tableView: UITableView!
    
    func viewDidLoad() {
        tableView.dataSource = self
    }

    func numberOfRows(inSection section: Int) -> Int {
        return 3
    }
    
    func tableView(cellForRowAt indexPath: Int) -> UITableViewCell {
        return UITableViewCell()
    }
}








//
//
//// **************************** //
//// **   DELEGATE IN SWIFT    ** //
//// **************************** //
//
//class UITableViewCell {
//
//}
//
//protocol UITableViewDataSource {
//    func numberOfRows(inSection section: Int) -> Int
//    func tableView(cellForRowAt indexPath: Int) -> UITableViewCell
//}
//
//class UITableView {
//
//    var dataSource: UITableViewDataSource?
//
//    private func setupTableViewCalledByTheSystem(inSection section: Int, at rowIndex: Int) {
//        // secret, private implementation
//
//        // at some random time, the system will call
//        dataSource!.numberOfRows(inSection: section)
//        dataSource?.tableView(cellForRowAt: rowIndex)
//    }
//}
//
//// tableView : YOU
//// self - photosTVC : Sam (your co-worker)
//// data of photos = coffee
//
//class PhotosTableViewController : UITableViewDataSource
//{
//    var tableView: UITableView!
//
//    func viewDidLoad() {
//        tableView.dataSource = self
//    }
//
//    func numberOfRows(inSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(cellForRowAt indexPath: Int) -> UITableViewCell {
//        return UITableViewCell()
//    }
//}
