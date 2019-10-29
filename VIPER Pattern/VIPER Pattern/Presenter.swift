//
//  Presenter.swift
//  VIPER Pattern
//
//  Created by iMac_VTCA on 10/14/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

class Presenter: PresenterProtocol, ListOutputInteractorProtocol {
    
    func navigateSomeWhere(item: Fruit, from: FruitListView) {
        self.wireFrame?.navigateScreen(item: item, from: from)
    }
    
    var interactor: ListInputInteractorProtocol?
    var wireFrame: RouterProtocol?
    var fruitListView: FruitListViewProtocol?
    
    func fruitListDidFetch(fruitList: [Fruit]) {
        fruitListView?.showListFruit(fruits: fruitList)
    }
    
    func getData() {
        self.interactor?.getAllFruits()
    }

      
}
