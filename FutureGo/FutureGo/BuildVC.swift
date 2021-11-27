//
//  BuildVC.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

class BuildManager {
    var model: AppModel
    var navigationConstroller: UINavigationController?
    
    init(model: AppModel) {
        self.model = model
    }
    
    func configure(model: AppModel) {
        self.model = model
        let rootVc = model.rootVC
        let vc = UIViewController()
        for element in rootVc.elements {
            vc.view.addSubview(element.gerRealElement())
        }
        self.navigationConstroller?.present(vc, animated: true, completion: nil)
    }
}
