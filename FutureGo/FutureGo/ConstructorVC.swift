//
//  ConstructorVC.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConstructorVC: UIViewController {
    
    var selectedElement: ElementModel?
    
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
    
    // MARK: - Model
    
    public var controllers = [ControllerModel]() {
        didSet{
            self.appMap.configure(with: self.controllers)
            self.controllersMap.configure(with: self.controllers)
        }
    }
    
    private let appMap = AppMapView()
    
    private lazy var controllersMap: ControllersMapView = {
        let view = ControllersMapView(selectOutput: self)
        view.output = self
        return view
    }()
    
    private let configComponentView = ConfigComponentView()
    
    public lazy var elementView: ElementTableView = {
        let view = ElementTableView()
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
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
        
        configComponentView.configure(with: [], idElement: nil, editingParametrOutput: nil, parentVC: nil)
    }
    
    private func setUpConrollerMap() {
        
        view.addSubview(controllersMap)
        
        self.controllersMap.pin(side: .topR, to: .bottom(self.controllBar))
        controllersMap.pinToSuperView(sides: [.bottomR])
        controllersMap.pin(side: .leftR, to: .right(appMap))
        controllersMap.pin(side: .rightR, to: .left(configComponentView))
        
        self.controllers.append(ControllerModel(name: "New", elements: []))
    }
    
    @objc func buildAction() {
        let build = BuildManager(model: AppModel(rootVC: self.controllers.first!, controllers: self.controllers))
        build.navigationConstroller = self.navigationController
        build.run()
//        self.navigationController?.pushViewController(UIViewController(), animated: true)
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

extension ConstructorVC: SelectElementOutput {
    func selectElement(_ element: ElementModel) {
        self.selectedElement = element
        configComponentView.configure(with: element.parametrs, idElement: element.id, editingParametrOutput: self, parentVC: self)
    }
}

extension ConstructorVC: EditingParametrOutput {
    func changeParametr(_ parametr: ConfigParametrModel, for idElement: String?) {
        let index = Int(controllersMap.visibleCells.count / 2)
        guard let cell = controllersMap.visibleCells[index] as? ControllersMapCell else {
            return
        }
        
        guard
            let needView = cell.subviews.first(where: { view in
                guard let drag = view as? Dragable else {
                    return false
                }
                return drag.id == idElement
            })
        else {
            return
        }
        
        guard let currentParams = cell.controllerModel?.elements.first(where: { el in
            el.id == idElement
        })?.parametrs else { return }
        
        var newParametrs = currentParams
        
        guard let curInd = currentParams.firstIndex(of: parametr) else { return }
        
        newParametrs.remove(at: curInd)
        newParametrs.insert(parametr, at: curInd)
        
        (needView as? Dragable)?.configure(with: newParametrs)
        needView.layoutIfNeeded()
    }
}

extension ConstructorVC: MapViweOutput {
    func realoadData(with controllers: [ControllerModel]) {
        self.controllers = controllers
    }
}
