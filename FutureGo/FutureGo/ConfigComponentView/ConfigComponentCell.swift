//
//  ConfigComponentCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

protocol EditingParametrOutput: AnyObject {
    func changeParametr(_ parametr: ConfigParametrModel, for idElement: String?)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        addSubview(nameLabel)
        nameLabel.pinToSuperView(sides: [.top(10), .left(10), .right(-10)])
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.placeholder = "Введите значение"
        
        addSubview(textField)
        textField.pinToSuperView(sides: [.left(10), .right(-10)])
        textField.pin(side: .top(5), to: .bottom(nameLabel))
        
        pin(side: .bottom(20), to: .bottom(textField))
        
        selectBtn.setTitle("Выбрать", for: .normal)
        selectBtn.setTitleColor(.black, for: .normal)
        selectBtn.addTarget(self, action: #selector(selectSome), for: .touchUpInside)
        
        addSubview(selectBtn)
        selectBtn.pinToSuperView(sides: [.left(10), .right(-10)])
        selectBtn.pin(side: .top(5), to: .bottom(nameLabel))
        selectBtn.setDemission(.height(20))
    }
    
    func configure(with model: ConfigParametrModel, idElement: String?, editingOutput: EditingParametrOutput?, parentVC: UIViewController?) {
        self.model = model
        self.idElement = idElement
        self.editingOutput = editingOutput
        self.parentVC = parentVC
        nameLabel.text = model.name
        
        switch model {
        case .title, .radius:
            selectBtn.isHidden = true
            textField.isHidden = false
            
        case .textColor, .backgroundColor, .backgroundImage:
            selectBtn.isHidden = false
            textField.isHidden = true
        case .action(_):
            selectBtn.isHidden = true
            textField.isHidden = true
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
        case .duration(_):
            break
        case .action(_):
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
