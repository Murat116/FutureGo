//
//  DragableView.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

protocol Dragable: AnyObject {
    var frame: CGRect { get set }
    var id: String { get set }
    func configure(with parametrs: [ConfigParametrModel])
}

protocol ParentView: UIView {
    func removewFromSuperview(type: ElementsType)
    func changeFrame(of: Dragable, to new: CGRect)
}

class DragableView: UIView, Dragable {
    
    var id: String
    let parentView: ParentView
    
    let model: ElementModel
    
    weak var selectOutput: SelectElementOutput?
    var tapGesture: UITapGestureRecognizer?
    
    init(frame: CGRect, model: ElementModel, parentView: ParentView, id: String, selectOutput: SelectElementOutput?) {
        self.id = id
        self.selectOutput = selectOutput
        self.parentView = parentView
        self.model = model
        super.init(frame: frame)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectElement)))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let locationLoc = gesture.location(in: self)
        let c : CGFloat = 40
        if locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            self.frame.origin.x += locationLoc.x
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        if self.frame.width - locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        if locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: locationLoc.y)
            self.frame.origin.x += locationLoc.x
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        if self.frame.width - locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: locationLoc.y)
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        
            let location = gesture.location(in: self.parentView)
            let draggedView = gesture.view
            draggedView?.center = location
        self.parentView.changeFrame(of: self, to: self.frame)
    }
    
    @objc func selectElement() {
        self.selectOutput?.selectElement(self.model)
    }
    
    func configure(with parametrs: [ConfigParametrModel]) {
        self.model.parametrs = parametrs
        parametrs.forEach { parametr in
            switch parametr {
            case let .backgroundColor(color):
                self.backgroundColor = color
            case let .radius(value):
                self.layer.cornerRadius = value ?? 0
            case let .action(selector):
                guard let selector = selector else { return }
                tapGesture = UITapGestureRecognizer(target: self, action: selector)
                self.addGestureRecognizer(tapGesture!)
            default:
                break
            }
        }
    }
}

// MARK: - DragableButton

class DragableButton: UIButton, Dragable {
    let parentView: ParentView
    var id: String
    
    let model: ElementModel
    weak var selectOutput: SelectElementOutput?
    
    init(frame: CGRect, model: ElementModel, parentView: ParentView, selectOutput: SelectElementOutput?, id: String) {
             self.id = id
        self.parentView = parentView
        self.model = model
        self.selectOutput = selectOutput
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectElement)))
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //siebel from oracle
    @objc func handler(gesture: UIPanGestureRecognizer){
        let locationLoc = gesture.location(in: self)
        let c : CGFloat = 40
        if locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            self.frame.origin.x += locationLoc.x
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        if self.frame.width - locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        if locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: locationLoc.y)
            self.frame.origin.x += locationLoc.x
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        if self.frame.width - locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: locationLoc.y)
            self.parentView.changeFrame(of: self, to: self.frame)
            return
        }
        
            let location = gesture.location(in: self.parentView)
            let draggedView = gesture.view
            draggedView?.center = location
        self.parentView.changeFrame(of: self, to: self.frame)
    }
    
    @objc func selectElement() {
        self.selectOutput?.selectElement(self.model)
    }
    
    func configure(with parametrs: [ConfigParametrModel]) {
        self.model.parametrs = parametrs
        parametrs.forEach { parametr in
            switch parametr {
            case let .title(text):
                self.setTitle(text, for: .normal)
            case let .textColor(color):
                guard let color = color else { break }
                self.setTitleColor(color, for: .normal)
            case let .backgroundColor(color):
                guard let color = color else { break }
                self.backgroundColor = color
            case let .radius(value):
                self.layer.cornerRadius = value ?? 0
            case let .backgroundImage(image):
                self.setImage(image, for: .normal)
            case let .action(selector):
                guard let selector = selector else { return }
                self.addTarget(self, action: selector, for: .touchUpInside)
            default:
                break
            }
        }
    }
}

class DragableLabel: DragableView {
    let label = UILabel()
    
    override init(frame: CGRect, model: ElementModel, parentView: ParentView, id: String, selectOutput: SelectElementOutput?) {
        super.init(frame: frame, model: model, parentView: parentView, id: id, selectOutput: selectOutput)
        self.addSubview(self.label)
        self.label.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with parametrs: [ConfigParametrModel]) {
        super.configure(with: parametrs)
        parametrs.forEach { parametr in
            switch parametr {
            case let .title(text):
                self.label.text = text
            case let .textColor(color):
                guard let color = color else { break }
                self.label.textColor = color
            case let .radius(value):
                self.layer.cornerRadius = value ?? 0
            case let .action(selector):
                guard let selector = selector else { return }
                tapGesture = UITapGestureRecognizer(target: self, action: selector)
                self.addGestureRecognizer(tapGesture!)
            default:
                break
            }
        }
    }
}

class DragableTableView: UITableView, Dragable {
    let parentView: ParentView
    var id: String
    
    weak var selectOutput: SelectElementOutput?
    
    init(frame: CGRect, parentView: ParentView, id: String, selectOutput: SelectElementOutput?) {
        self.selectOutput = selectOutput
        self.id = id
        self.parentView = parentView
        super.init(frame: frame, style: .insetGrouped)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
    }
    
    func configure(with parametrs: [ConfigParametrModel]) {
        
    }
}

class DragableImageView: DragableView {
    let imageView = UIImageView()
    
    override init(frame: CGRect, model: ElementModel, parentView: ParentView, id: String, selectOutput: SelectElementOutput?) {
        super.init(frame: frame, model: model, parentView: parentView, id: id, selectOutput: selectOutput)
        self.addSubview(self.imageView)
        self.imageView.pinToSuperView()
        self.imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with parametrs: [ConfigParametrModel]) {
        super.configure(with: parametrs)
        parametrs.forEach { parametr in
            switch parametr {
            case let .backgroundImage(image):
                self.imageView.image = image
            case let .radius(value):
                self.imageView.layer.cornerRadius = value ?? 0
            default:
                break
            }
        }
    }
}

class DragableTextField: DragableView {
    
    let textField = UITextField()
    
    override init(frame: CGRect, model: ElementModel, parentView: ParentView, id: String, selectOutput: SelectElementOutput?) {
        super.init(frame: frame, model: model, parentView: parentView, id: id, selectOutput: selectOutput)
        self.backgroundColor = .clear
        self.addSubview(self.textField)
        self.textField.isUserInteractionEnabled = false
        self.textField.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with parametrs: [ConfigParametrModel]) {
        self.model.parametrs = parametrs
        parametrs.forEach { parametr in
            switch parametr {
            case let .title(text):
                self.textField.text = text
            case let .radius(value):
                self.textField.layer.cornerRadius = value ?? 0
            case let .backgroundColor(color):
                guard let color = color else { break }
                self.textField.backgroundColor = color
            case let .textColor(color):
                guard let color = color else { break }
                self.textField.textColor = color
            default:
                break
            }
        }
    }
}

class DragableSwipe: DragableView {
    
}
