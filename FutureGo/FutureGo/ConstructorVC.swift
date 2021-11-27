//
//  ConstructorVC.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConstructorVC: UIViewController {
    
    private var controllBar: UIStackView {
        let stackView = UIStackView(arrangedSubviews: [self.addController,self.buildBtn,self.addBtn])
        self.view.addSubview(stackView)
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pinToSuperView(sides: [.leftR,.rightR,.topR])
        stackView.setDemission(.height(50))
        return stackView
    }
    
    private lazy var addController: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add new View Controller", for: .normal)
        btn.addTarget(self, action: #selector(self.addControllerAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buildBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Build", for: .normal)
        btn.addTarget(self, action: #selector(self.buildAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add View", for: .normal)
        btn.addTarget(self, action: #selector(self.showElementTable), for: .touchUpInside)
        return btn
    }()
    
    public var controllers = [ControllerModel]() {
        didSet{
            self.appMap.configure(with: self.controllers)
            self.controllersMap.configure(with: self.controllers)
        }
    }
    
    private let appMap = AppMapView()
    
    private lazy var controllersMap: ControllersMapView = {
        return ControllersMapView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    }()
    
    private let configComponentView = ConfigComponentView()
    
    public lazy var elementView: ElementTableView = {
        let view = ElementTableView()
        view.isHidden = true
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
        
        self.appMap.pin(side: .topR, to: .bottom(self.controllBar))
        appMap.pinToSuperView(sides: [.leftR, .bottomR])
        appMap.setDemission(.width(200))
    }
    
    private func setUpConfigComponentView() {
        configComponentView.backgroundColor = .white
        
        view.addSubview(configComponentView)
        
        self.configComponentView.pin(side: .topR, to: .bottom(self.controllBar))
        configComponentView.pinToSuperView(sides: [.bottomR])
        configComponentView.pin(side: .rightR, to: .left(elementView))
        configComponentView.setDemission(.width(200))
        
        configComponentView.configure(with: ConfigParametrModel.testElements)
    }
    
    private func setUpConrollerMap() {
        
        view.addSubview(controllersMap)
        
        self.controllersMap.pin(side: .topR, to: .bottom(self.controllBar))
        controllersMap.pinToSuperView(sides: [.bottomR])
        controllersMap.pin(side: .leftR, to: .right(appMap))
        controllersMap.pin(side: .rightR, to: .left(configComponentView))
        
    }
    
    @objc func buildAction() {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    @objc func showElementTable() {
        self.elementView.isHidden = false
    }
    
    @objc func addControllerAction() {
        let alert = UIAlertController(title: "Введите имя контроллера", message: nil, preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let text = textField?.text
            let model = ControllerModel(name: text!, elements: [])
            self.controllers.append(model)
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
}
