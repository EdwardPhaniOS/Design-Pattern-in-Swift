//
//  FruitListProtocol.swift
//  VIPER Pattern
//
//  Created by iMac_VTCA on 10/14/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

protocol FruitListViewProtocol: class {
    
    func showListFruit(fruits: [Fruit])
}

protocol ListInputInteractorProtocol: class {
    var presenter: ListOutputInteractorProtocol? {get set}
    
    func getAllFruits()
}

protocol ListOutputInteractorProtocol: class {
    
    func fruitListDidFetch(fruitList: [Fruit])
}

protocol PresenterProtocol: class {
    
    var wireFrame: RouterProtocol? {get set}
    var fruitListView: FruitListViewProtocol? {get set}
    var interactor: ListInputInteractorProtocol? {get set}
    
    func getData()
    
    func navigateSomeWhere(item: Fruit, from: FruitListView)
}

protocol RouterProtocol: class {
    
    static func createModule(fruitListRef: FruitListView)
    
    func navigateScreen(item: Fruit, from: FruitListView)
}
