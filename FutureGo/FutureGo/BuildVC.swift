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
        let vc = PresentationVC()
        for element in rootVc.elements {
            let view = element.gerRealElement(model: element)
            vc.mainView.addSubview(view)
        }
        self.navigationConstroller?.pushViewController(vc, animated: true)
        self.navigationConstroller?.navigationBar.isHidden = false
//        self.navigationConstroller?.present(vc, animated: true, completion: nil)
    }
}

class PresentationVC: UIViewController {
    public let mainView = UIView()
    private let image = UIImageView(image: UIImage(named: "IphoneView"))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.addSubview(self.mainView)
        self.mainView.pinToSuperView(sides: [.centerXR, .centerYR])
        self.mainView.setDemission(.height(812))
        self.mainView.setDemission(.width(375))
        self.mainView.addSubview(self.image)
        self.image.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
