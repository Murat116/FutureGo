//
//  DragableView.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit


class DragableView: UIView {
    
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.frame.midX >= self.parentView.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = self.parentView.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = 40
                }, completion: nil)
            }
        }
    }
}

class DragableButton: UIButton {
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.frame.midX >= self.parentView.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = self.parentView.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = 40
                }, completion: nil)
            }
        }
    }
}

class DragableLabel: UILabel {
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.frame.midX >= self.parentView.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = self.parentView.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = 40
                }, completion: nil)
            }
        }
    }
}

class DragableTableView: UITableView {
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame, style: .insetGrouped)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.frame.midX >= self.parentView.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = self.parentView.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = 40
                }, completion: nil)
            }
        }
    }
}

class DragableImageView: UIImageView {
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.frame.midX >= self.parentView.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = self.parentView.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = 40
                }, completion: nil)
            }
        }
    }
}

class DragableTextField: UITextField {
    let parentView: UIView
    
    init(frame: CGRect, parentView: UIView) {
        self.parentView = parentView
        super.init(frame: frame)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.parentView)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.frame.midX >= self.parentView.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = self.parentView.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.center.x = 40
                }, completion: nil)
            }
        }
    }
}
