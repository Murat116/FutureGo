//
//  ConstructorVC.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConstructorVC: UIViewController {
    
    private let appMap = AppMapView()
    
    private lazy var controllersMap: ControllersMapView = {
        return ControllersMapView(selectOutput: self)
    }()
    
    private let configComponentView = ConfigComponentView()
    
    public lazy var elementView: ElementTableView = {
        let view = ElementTableView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.elementView)
        self.elementView.pinToSuperView(sides: [.topR,.rightR,.bottomR])
        self.elementView.setDemission(.width(100))
        self.elementView.output = self.controllersMap
        
        setUpAppMap()
        setUpConfigComponentView()
        setUpConrollerMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controllersMap.width = self.configComponentView.frame.origin.x - self.appMap.frame.maxX
        self.controllersMap.reloadData()
    }
    
    private func setUpAppMap() {
        appMap.backgroundColor = .white
        
        view.addSubview(appMap)
        
        appMap.pinToSuperView(sides: [.leftR, .topR, .bottomR])
        appMap.setDemission(.width(200))
        
        appMap.configure(with: ControllerModel.testItems)
    }
    
    private func setUpConfigComponentView() {
        configComponentView.backgroundColor = .white
        
        view.addSubview(configComponentView)
        
        configComponentView.pinToSuperView(sides: [.topR, .bottomR])
        configComponentView.pin(side: .rightR, to: .left(elementView))
        configComponentView.setDemission(.width(200))
        
        configComponentView.configure(with: [])
    }
    
    private func setUpConrollerMap() {
        
        view.addSubview(controllersMap)
        
        controllersMap.pinToSuperView(sides: [.topR, .bottomR])
        controllersMap.pin(side: .leftR, to: .right(appMap))
        controllersMap.pin(side: .rightR, to: .left(configComponentView))
        
        controllersMap.configure(with: ControllerModel.testItems)
    }
}

extension ConstructorVC: SelectElementOutput {
    func selectElement(_ element: ElementModel) {
        configComponentView.configure(with: element.getParametrs())
    }
}
