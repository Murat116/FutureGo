//
//  ConstructorVC.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class TopView: UIView {
    let backIcon = UIImageView(image: UIImage(named: "backIcon"))
    let avatarImage = UIImageView(image: UIImage(named: "avatar"))
    let namePrLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.text = "Мое первое приложение"
        return lbl
    }()
    let appFlow: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.text = "Appflow"
        lbl.textColor = UIColor(hex: "#547AEB")
        return lbl
    }()
    
    public lazy var shareButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.layer.cornerRadius = 4
        btn.backgroundColor = .black
        btn.setTitle("Поделиться", for: .normal)
        return btn
    }()
    
    public lazy var presentButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.layer.cornerRadius = 4
        btn.backgroundColor = .black
        btn.setTitle("Презентовать", for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = .white
        
        self.addSubview(backIcon)
        backIcon.pinToSuperView(sides: [.centerYR, .left(30)])
        backIcon.setDemission(.height(24))
        backIcon.setDemission(.width(24))
        
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 4
        
        self.addSubview(avatarImage)
        avatarImage.pinToSuperView(sides: [.centerYR])
        avatarImage.pin(side: .left(24), to: .right(backIcon))
        avatarImage.setDemission(.height(42))
        avatarImage.setDemission(.width(42))
        
        self.addSubview(namePrLabel)
        namePrLabel.pin(side: .left(19), to: .right(avatarImage))
        namePrLabel.pinToSuperView(sides: [.centerYR])
        
        self.addSubview(shareButton)
        shareButton.pinToSuperView(sides: [.centerYR, .right(-30)])
        shareButton.setDemission(.height(45))
        shareButton.setDemission(.width(135))
        
        self.addSubview(presentButton)
        presentButton.pinToSuperView(sides: [.centerYR])
        presentButton.pin(side: .right(-24), to: .left(shareButton))
        presentButton.setDemission(.height(45))
        presentButton.setDemission(.width(135))
        
        let line = UIView()
        addSubview(line)
        line.pinToSuperView(sides: [.leftR, .rightR, .bottomR])
        line.setDemission(.height(1))
        line.backgroundColor = UIColor(hex: "#4E4C4C")
    }
}

class ConstructorVC: UIViewController {
    
    static var keyName: String = ""
    
    var selectedElement: ElementModel?
    
    let topView = TopView()
    
    public lazy var label: UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        label.pinToSuperView(sides: [.bottom(-20),.centerXR])
        return label
    }()
    
    private lazy var addController: UIButton = {
        let btn = UIButton()
        btn.setTitle("Добавить экран", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.layer.cornerRadius = 4
        btn.backgroundColor = .black
        
        btn.addTarget(self, action: #selector(self.addControllerAction), for: .touchUpInside)
        return btn
    }()
    
    let segmContr: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Свойства элемента", "Добавить элемент"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .clear
        sc.addTarget(self, action: #selector(sgTap(_:)), for: .valueChanged)
        return sc
    }()
    
    @objc func sgTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.elementView.isHidden = true
            self.configComponentView.isHidden = false
        case 1:
            self.elementView.isHidden = false
            self.configComponentView.isHidden = true
        default:
            break
        }
    }
    
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

    let welcomeImg = UIImageView(image: UIImage(named: "welcome"))
    
    @objc func removeWelcome() {
        welcomeImg.removeFromSuperview()
    }
    
    @objc func shareTap() {
        let parser = Parser()
        parser.write(self.controllers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#DEDFDF")
        self.navigationController?.navigationBar.isHidden = true
        
        topView.shareButton.addTarget(self, action: #selector(shareTap), for: .touchUpInside)
        topView.presentButton.addTarget(self, action: #selector(self.buildAction), for: .touchUpInside)
        
        self.elementView.output = self.controllersMap
        
        view.addSubview(topView)
        topView.pinToSuperView(sides: [.top(20),.leftR, .rightR])
        topView.setDemission(.height(80))
        
        view.addSubview(segmContr)
        segmContr.pinToSuperView(sides: [.rightR])
        segmContr.pin(side: .top(5), to: .bottom(topView))
        segmContr.setDemission(.width(300))
        segmContr.setDemission(.height(50))
        
        self.view.addSubview(elementView)
        elementView.pinToSuperView(sides: [.rightR,.bottomR])
        elementView.pin(side: .topR, to: .bottom(self.segmContr))
        elementView.setDemission(.width(300))
        
        setUpAppMap()
        setUpConfigComponentView()
        setUpConrollerMap()
        
        welcomeImg.isUserInteractionEnabled = true
        view.addSubview(welcomeImg)
        welcomeImg.pinToSuperView()
        welcomeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeWelcome)))
        
        BackendModel.reqeustToTask()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.controllersMap.width = self.configComponentView.frame.origin.x - self.appMap.frame.maxX
    }
    
    private func setUpAppMap() {
        appMap.backgroundColor = .white
        
        view.addSubview(appMap)
        
        self.appMap.pin(side: .topR, to: .bottom(self.topView))
        appMap.pinToSuperView(sides: [.leftR, .bottomR])
        appMap.setDemission(.width(300))
        
        view.addSubview(addController)
        addController.pinToSuperView(sides: [.left(35), .bottom(-30)])
        addController.setDemission(.height(45))
        addController.setDemission(.width(135))
    }
    
    private func setUpConfigComponentView() {
        configComponentView.backgroundColor = .white
        
        view.addSubview(configComponentView)
        
        self.configComponentView.pin(side: .topR, to: .bottom(self.segmContr))
        configComponentView.pinToSuperView(sides: [.bottomR, .rightR])
        configComponentView.setDemission(.width(300))
        
        configComponentView.configure(with: [], idElement: nil, editingParametrOutput: nil, parentVC: nil)
    }
    
    private func setUpConrollerMap() {
        
        view.addSubview(controllersMap)
        
        self.controllersMap.pin(side: .topR, to: .bottom(self.topView))
        controllersMap.pinToSuperView(sides: [.bottomR])
        controllersMap.pin(side: .leftR, to: .right(appMap))
        controllersMap.pin(side: .rightR, to: .left(configComponentView))
        
        self.controllers.append(ControllerModel(name: "Main", elements: []))
    }
    var recognizer: UITapGestureRecognizer?
    var blurEffect: UIBlurEffect?
    var build: BuildManager?
    @objc func buildAction() {
        self.build = BuildManager(model: AppModel(controllers: self.controllers))
        self.build!.navigationConstroller = self.navigationController
        self.build!.run()
        self.blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        self.recognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideBlur))
        self.view.addGestureRecognizer(self.recognizer!)
    }
    
    @objc func hideBlur() {
        for subview in self.view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        self.build?.hide()
        self.build = nil
        guard let recognizer = self.recognizer else {
            return
        }

        self.view.removeGestureRecognizer(recognizer)
        self.recognizer = nil
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
    
    @objc func addBack() {
        let alert = UIAlertController(title: "Данные модели", message: nil, preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Ключ"
        }

        alert.addTextField { (textField) in
            textField.text = "Значение"
        }
        
        alert.addTextField { (textField) in
            textField.text = "Тип"
        }

        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let text = alert?.textFields![0].text // Force unwrapping because we know it exists.
            if self.label.text == nil {
                self.label.text = (" Ключ " + text!)
            } else {
                self.label.text! += (" Ключ " + text!)
            }
            
            let text1 = alert?.textFields![1].text // Force unwrapping because we know it exists.
            if self.label.text == nil {
                self.label.text = (" Значение " + text1!)
            } else {
                self.label.text! += (" Значение " + text1!)
            }
            
            let text2 = alert?.textFields![2].text // Force unwrapping because we know it exists.
            if self.label.text == nil {
                self.label.text = (" Тип " + text2!)
            } else {
                self.label.text! += (" Тип " + text2!)
            }
            
            if text2 == "String" {
                ConstructorVC.keyName = text!
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func addUrlaction() {
        let alert = UIAlertController(title: "Введите URL Get запроса", message: nil, preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "URL"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let text = textField?.text
            if self.label.text == nil {
                self.label.text = ("URL Get запроса " + text!)
            } else {
                self.label.text! += ("URL Get запроса " + text!)
            }
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
    }
    
    func getControllers() -> [ControllerModel] {
        self.controllers
    }
}

extension ConstructorVC: MapViweOutput {
    func realoadData(with controllers: [ControllerModel]) {
        self.controllers = controllers
    }
}
