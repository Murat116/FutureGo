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
        allControllers = []
        self.selfNav?.view.removeFromSuperview()
        self.selfNav = nil
        self.popupWindow?.resignKey()
        self.popupWindow?.rootViewController = nil
        self.popupWindow = nil
    }
    
    var allControllers = [PresentationVC]()
    
    func run() {
        allControllers = []
        
        model.controllers.forEach { controllerModel in
            let vc = PresentationVC()
            vc.controllerModel = controllerModel
            allControllers.append(vc)
        }
        
        allControllers.forEach { vc in
            guard let vcModel = vc.controllerModel else { return }
            vcModel.elements.forEach { elementModel in
                let view = elementModel.getRealElement(parentView: vc.mainView)
                vc.mainView.addSubview(view)
                
                if
                    var view = view as? TappedViewProtocol,
                    let idPr = view.idContrForPush,
                    let prVC = allControllers.first(where: { vc in
                        vc.controllerModel?.id ?? "" == idPr
                    })
                {
                    view.tapCompl = {
                        vc.present(prVC, animated: true)
//                        self.selfNav?.pushViewController(prVC, animated: true)
                    }
                }
            }
        }
        
        guard let rootVC = allControllers.first else {
            return
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
        popupWindow?.windowLevel = UIWindow.Level.alert + 1
        popupWindow?.rootViewController = self.selfNav
        popupWindow?.makeKeyAndVisible()
        self.selfNav?.present(rootVC, animated: true)
    
    }
}

class PresentationVC: UIViewController {
    var controllerModel: ControllerModel?
    
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

protocol TappedViewProtocol {
    var tapCompl: (() -> Void)? { get set }
    var idContrForPush: String? { get }
}

class TappedBtn: UIButton, TappedViewProtocol {
    var tapCompl: (() -> Void)?
    var idContrForPush: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(didTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapped() {
        self.tapCompl?()
    }
}
class TappedView: UIView, TappedViewProtocol {
    var tapCompl: (() -> Void)?
    var idContrForPush: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapped() {
        self.tapCompl?()
    }
}

class TappedLabel: UILabel, TappedViewProtocol {
    var tapCompl: (() -> Void)?
    var idContrForPush: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapped() {
        self.tapCompl?()
    }
}

class TappedImageView: UIImageView, TappedViewProtocol {
    var tapCompl: (() -> Void)?
    var idContrForPush: String?
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapped)))
        self.addSubview(self.label)
        self.label.pinToSuperView(sides: [.centerXR, .centerYR])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapped() {
        self.tapCompl?()
    }
}
