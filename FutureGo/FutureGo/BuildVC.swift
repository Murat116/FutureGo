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
    var popupWindow: UIWindow? = nil
    var selfNav: UINavigationController?
    
    init(model: AppModel) {
        self.model = model
    }
    
    func hide() {
        self.selfNav?.view.removeFromSuperview()
        self.selfNav = nil
        self.popupWindow?.resignKey()
        self.popupWindow?.rootViewController = nil
        self.popupWindow = nil
    }
    
    func run() {
        
        let vc = PresentationVC()
        let rootVc = model.rootVC
        
        for element in rootVc.elements {
            let view = element.gerRealElement()
            vc.mainView.addSubview(view)
//            for subElement in element {
//                subElement.get
//            }
        }
        
        
        let windowScene = UIApplication.shared
                        .connectedScenes
                        .filter { $0.activationState == .foregroundActive }
                        .first
        if let windowScene = windowScene as? UIWindowScene {
            popupWindow = UIWindow(windowScene: windowScene)
        }
        self.selfNav = UINavigationController(rootViewController: UIViewController())
        popupWindow?.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        popupWindow?.center = self.navigationConstroller!.view.center
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        popupWindow?.rootViewController = self.selfNav
        popupWindow?.makeKeyAndVisible()
        self.selfNav?.present(vc, animated: true)
    
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


