//
//  ConstructorVC.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConstructorVC: UIViewController {
    
    private let appMap = UIView()
    
    private let controllersMap = ControllersMapView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private let configComponentView = UIView()
    
    private lazy var elementView: ElementTableView = {
        let view = ElementTableView(output: self)
        return view
    }()
    
    override func loadView() {
        self.view = backView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAppMap()
        setUpConfigComponentView()
        self.view.addSubview(self.elementView)
        self.elementView.pinToSuperView(sides: [.topR,.rightR,.bottomR])
        self.elementView.setDemission(.width(100))
    }
    
    private func setUpAppMap() {
        appMap.backgroundColor = .white
        
        view.addSubview(appMap)
        
        appMap.pinToSuperView(sides: [.leftR, .topR, .bottomR])
        appMap.setDemission(.width(200))
    }
    
    private func setUpConfigComponentView() {
        configComponentView.backgroundColor = .white
        
        view.addSubview(configComponentView)
        
        configComponentView.pinToSuperView(sides: [.rightR, .topR, .bottomR])
        configComponentView.setDemission(.width(200))
    }
    
    private func setUpConrollerMap() {
        
        view.addSubview(controllersMap)
        
        controllersMap.pinToSuperView(sides: [.topR, .bottomR])
        controllersMap.pin(side: .leftR, to: .right(appMap))
        controllersMap.pin(side: .rightR, to: .left(configComponentView))
        
        controllersMap.configure(with: ControllerModel.testItems)
    }
}

extension ConstructorVC: ElementTableViewOutput {
    func addElement(_ element: ElementsType) {
        let view = element.getUIProection(parentView: self.view)
        self.view.addSubview(view)
    }
}
