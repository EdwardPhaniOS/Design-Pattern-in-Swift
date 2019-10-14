//
//  Interactor.swift
//  VIPER Pattern
//
//  Created by iMac_VTCA on 10/14/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

class Interactor: ListInputInteractorProtocol {
    
    var presenter: ListOutputInteractorProtocol?
    
    func getAllFruits() {
        presenter?.fruitListDidFetch(fruitList: dummyData)
    }
    
}
