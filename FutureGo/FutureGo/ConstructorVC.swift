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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAppMap()
        setUpConfigComponentView()
        setUpConrollerMap()
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

