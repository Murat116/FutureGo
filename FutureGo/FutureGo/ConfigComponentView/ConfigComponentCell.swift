//
//  ConfigComponentCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

protocol EditingParametrOutput: AnyObject {
    func changeParametr(_ parametr: ConfigParametrModel, for idElement: String?)
    func getControllers() -> [ControllerModel]
}

class ConfigBackendParametrCell: UITableViewCell {
    
    weak var parentVC: UIViewController?
    
    var parametrsCount: Int = 0
    var index: Int = 0
    
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        selectionStyle = .none
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#DEDFDF")
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(button)
        
        button.pinToSuperView(sides: [.left(15), .right(-15), .top(8)])
        contentView.pin(side: .bottom(8), to: .bottom(button))
    }
    
    func configure(index: Int, paramsCount: Int, parentVC: UIViewController?) {
        self.parentVC = parentVC
        self.index = index
        self.parametrsCount = paramsCount
        button.setTitle(index == paramsCount ? "Добавить url" : "Добавить новую модель", for: .normal)
    }
    
    @objc func tap() {
        if let parent = parentVC as? ConstructorVC {
            if index == parametrsCount {
                parent.addUrlaction()
            } else {
                parent.addBack()
            }
        }
    }
}

class ConfigComponentCell: UITableViewCell {
    
    let configView = ConfigComponentElementView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        selectionStyle = .none
        
        contentView.addSubview(configView)
        
        configView.pinToSuperView(sides: [.leftR, .rightR, .topR])
        contentView.pin(side: .bottomR, to: .bottom(configView))
    }
    
    func configure(with model: ConfigParametrModel, idElement: String?, editingOutput: EditingParametrOutput?, parentVC: UIViewController?) {
        configView.configure(with: model, idElement: idElement, editingOutput: editingOutput, parentVC: parentVC)
    }
}

class ConfigComponentElementView: UIView {
    
    var idElement: String?
    var model: ConfigParametrModel?
     
    weak var parentVC: UIViewController?
    weak var editingOutput: EditingParametrOutput?
    
    let nameLabel = UILabel()
    
    let textField = UITextField()
    let selectBtn = UIButton()
    
    let actionPicker = UIPickerView()
    
    var bottomToPicker: NSLayoutConstraint?
    var bottomToTextField: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        nameLabel.textColor = UIColor(hex: "#4E4C4C")
        
        addSubview(nameLabel)
        nameLabel.pinToSuperView(sides: [.top(10), .left(10), .right(-10)])
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.placeholder = "Введите значение"
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        
        addSubview(textField)
        textField.pinToSuperView(sides: [.left(10), .right(-10)])
        textField.pin(side: .top(5), to: .bottom(nameLabel))
        
        self.bottomToTextField = pin(side: .bottom(20), to: .bottom(textField))
        
        selectBtn.setTitle("Выбрать", for: .normal)
        selectBtn.setTitleColor(.black, for: .normal)
        selectBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        selectBtn.addTarget(self, action: #selector(selectSome), for: .touchUpInside)
        
        addSubview(selectBtn)
        selectBtn.pinToSuperView(sides: [.left(10), .right(-10)])
        selectBtn.pin(side: .top(5), to: .bottom(nameLabel))
        selectBtn.setDemission(.height(20))
        
        actionPicker.dataSource = self
        actionPicker.delegate = self
        
        addSubview(actionPicker)
        actionPicker.pinToSuperView(sides: [.left(10), .right(-10)])
        actionPicker.pin(side: .top(5), to: .bottom(nameLabel))
        actionPicker.setDemission(.height(150))
     
        self.bottomToPicker = pin(side: .bottom(20), to: .bottom(actionPicker), isActivate: false)
    }
    
    func configure(with model: ConfigParametrModel, idElement: String?, editingOutput: EditingParametrOutput?, parentVC: UIViewController?) {
        self.model = model
        self.idElement = idElement
        self.editingOutput = editingOutput
        self.parentVC = parentVC
        nameLabel.text = model.name
        
        actionPicker.isHidden = true
        
        switch model {
        case .title, .radius:
            selectBtn.isHidden = true
            textField.isHidden = false
            bottomToPicker?.isActive = false
            bottomToTextField?.isActive = true
            
        case .textColor, .backgroundColor, .backgroundImage:
            selectBtn.isHidden = false
            textField.isHidden = true
            bottomToPicker?.isActive = false
            bottomToTextField?.isActive = true
            
        case .action:
            actionPicker.isHidden = false
            selectBtn.isHidden = true
            textField.isHidden = true
            bottomToPicker?.isActive = true
            bottomToTextField?.isActive = false
        case .duration(_):
            selectBtn.isHidden = true
            textField.isHidden = true
        }
        
        switch model {
        case let .title(text):
            textField.text = text
        case let .textColor(color):
            guard let color = color else { break }
            selectBtn.setTitle(color.hex, for: .normal)
        case let .backgroundColor(color):
            guard let color = color else { break }
            selectBtn.setTitle(color.hex, for: .normal)
        case let .radius(value):
            guard let val = value else { break }
            textField.text = "\(val)"
        case .backgroundImage(_):
            break
        case .action:
            actionPicker.reloadAllComponents()
        case .duration(_):
            break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let model = model else { return }
        
        var newParametr: ConfigParametrModel? = nil
        
        switch model {
        case .title(_):
            newParametr = .title(textField.text)
        case .radius(_):
            guard let val = Double(textField.text ?? "") else { break }
            newParametr = .radius(CGFloat(val))
        default:
            break
        }
        
        guard let param = newParametr else { return }
        self.editingOutput?.changeParametr(param, for: idElement)
    }
    
    @objc func selectSome() {
        switch self.model {
        case .textColor, .backgroundColor:
            
            let picker = UIColorPickerViewController()
            picker.delegate = self
            parentVC?.present(picker, animated: true, completion: nil)
            
        case .backgroundImage:
            
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imgPicker.allowsEditing = true
            
            parentVC?.present(imgPicker, animated: true, completion: nil)
            
        default:
            break
        }
    }
}

extension ConfigComponentElementView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        guard let model = model else { return }
        
        self.selectBtn.setTitle(viewController.selectedColor.hex, for: .normal)
        
        var newParametr: ConfigParametrModel? = nil
        
        switch model {
        case .textColor:
            newParametr = .textColor(viewController.selectedColor)
        case .backgroundColor:
            newParametr = .backgroundColor(viewController.selectedColor)
        case .duration(_):
            guard let val = Double(textField.text ?? "") else { break }
            newParametr = .duration(CGFloat(val))
        default:
            break
        }
        
        guard let param = newParametr else { return }
        self.editingOutput?.changeParametr(param, for: idElement)
    }
}

extension ConfigComponentElementView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let model = model, let image = info[.editedImage] as? UIImage else { return }
        
        var newParametr: ConfigParametrModel? = nil
        
        switch model {
        case .backgroundImage:
            newParametr = .backgroundImage(image)
        default:
            break
        }
        
        guard let param = newParametr else { return }
        self.editingOutput?.changeParametr(param, for: idElement)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
}

extension ConfigComponentElementView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.editingOutput?.getControllers().count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.editingOutput?.getControllers()[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var newParametr: ConfigParametrModel? = nil
        
        switch model {
        case .action:
            newParametr = .action(self.editingOutput?.getControllers()[row].id)
        default:
            break
        }
        
        guard let param = newParametr else { return }
        self.editingOutput?.changeParametr(param, for: idElement)
    }
}
