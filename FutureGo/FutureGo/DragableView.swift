//
//  DragableView.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

protocol Dragable: AnyObject {}

class DragableView: UIView, Dragable {
    
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
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
        let locationLoc = gesture.location(in: self)
        let c : CGFloat = 40
        if locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            self.frame.origin.x += locationLoc.x
            return
        }
        if self.frame.width - locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            return
        }
        if locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: locationLoc.y)
            self.frame.origin.x += locationLoc.x
            return
        }
        if self.frame.width - locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: locationLoc.y)
            return
        }
        
            let location = gesture.location(in: self.parentView)
            let draggedView = gesture.view
            draggedView?.center = location
    }
}

class DragableButton: UIButton, Dragable {
    let parentView: UIView
    
    let model: ElementModel
    weak var selectOutput: SelectElementOutput?
    
    init(frame: CGRect, model: ElementModel, parentView: UIView, selectOutput: SelectElementOutput?) {
        self.parentView = parentView
        self.model = model
        self.selectOutput = selectOutput
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectElement)))
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
            return
        }
        if self.frame.width - locationLoc.x < c, locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: self.frame.height - locationLoc.y)
            self.frame.origin.y += locationLoc.y
            return
        }
        if locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: self.frame.width - locationLoc.x, height: locationLoc.y)
            self.frame.origin.x += locationLoc.x
            return
        }
        if self.frame.width - locationLoc.x < c, self.frame.height - locationLoc.y < c {
            self.frame.size = CGSize(width: locationLoc.x, height: locationLoc.y)
            return
        }
        
            let location = gesture.location(in: self.parentView)
            let draggedView = gesture.view
            draggedView?.center = location
    }
    
    @objc func selectElement() {
        self.selectOutput?.selectElement(self.model)
    }
}

class DragableLabel: DragableView {
    let label = UILabel()
    
    override init(frame: CGRect, parentView: UIView) {
        super.init(frame: frame, parentView: parentView)
        self.addSubview(self.label)
        self.label.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DragableTableView: UITableView, Dragable {
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
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
}

class DragableImageView: DragableView {
    let imageView = UIImageView()
    
    override init(frame: CGRect, parentView: UIView) {
        super.init(frame: frame, parentView: parentView)
        self.addSubview(self.imageView)
        self.imageView.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DragableTextField: DragableView {
    
    let textField = UITextField()
    
    override init(frame: CGRect, parentView: UIView) {
        super.init(frame: frame, parentView: parentView)
        self.addSubview(self.textField)
        self.textField.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
