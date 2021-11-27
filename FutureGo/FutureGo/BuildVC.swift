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
    
    func run() {
        let rootVc = model.rootVC
        let vc = UIViewController()
        for element in rootVc.elements {
            vc.view.addSubview(element.gerRealElement())
        }
        self.navigationConstroller?.pushViewController(vc, animated: true)
//        self.navigationConstroller?.present(vc, animated: true, completion: nil)
    }
}
