//
//  Router.swift
//  VIPER Pattern
//
//  Created by iMac_VTCA on 10/14/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

class Router: RouterProtocol {
    func navigateScreen(item: Fruit, from: FruitListView) {
        
        if let view = from.storyboard?.instantiateViewController(identifier: "abc") {
            from.navigationController?.pushViewController(view, animated: true)
        }
        
    }
    

    class func createModule(fruitListRef: FruitListView) {
        let presenter = Presenter()
        let interactor = Interactor()
    
        fruitListRef.presenter = presenter
        fruitListRef.presenter?.wireFrame = Router()
        fruitListRef.presenter?.fruitListView = fruitListRef
        fruitListRef.presenter?.interactor = interactor
        fruitListRef.presenter?.interactor?.presenter = presenter
        
    }
    
}
