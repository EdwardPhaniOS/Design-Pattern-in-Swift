//
//  FruitListView.swift
//  VIPER Pattern
//
//  Created by iMac_VTCA on 10/14/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

var dummyData = [Fruit(name: "Cam", quantity: 10), Fruit(name: "Xoai", quantity: 100), Fruit(name: "Man", quantity: 80)]


class FruitListView: UITableViewController, FruitListViewProtocol {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Router.createModule(fruitListRef: self)
        presenter?.getData()
    
    }
    
    var fruits = [Fruit]()
    var presenter: PresenterProtocol?
    
    func showListFruit(fruits: [Fruit]) {
        self.fruits = fruits
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailViewCell", for: indexPath) as! DetailViewCell
        cell.fruitName.text = fruits[indexPath.row].name
        cell.quantity.text = "\(fruits[indexPath.row].quantity)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fruits[indexPath.row]
        
        self.presenter?.wireFrame?.navigateScreen(item: item, from: self)
        
    }
    

}
