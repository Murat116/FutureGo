//
//  extension Constrint.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

//MARK: Constraint

extension UIView {
    
    // MARK: - Instance Methods
    func pinToSuperView(sides: [Side] = Side.allSides) {
        guard let view = self.superview else { return }
        self.pin(sides: sides, toSameSidesOn: view)
    }
    
    func pin(side: Side, toSameSidesOn view: UIView) {
        self.pin(sides: [side], toSameSidesOn: view)
    }
    
    func pin(sides: [Side] = Side.allSides, toSameSidesOn view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        for side in sides {
            let layout: NSLayoutConstraint
            switch side {
            case .top(let cGFloat, let uILayoutPriority):
                layout = self.topAnchor.constraint(equalTo: view.topAnchor, constant: cGFloat)
                layout.priority = uILayoutPriority
            case .bottom(let cGFloat, let uILayoutPriority):
                layout = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: cGFloat)
                layout.priority = uILayoutPriority
            case .left(let cGFloat, let uILayoutPriority):
                layout = self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: cGFloat)
                layout.priority = uILayoutPriority
            case .right(let cGFloat, let uILayoutPriority):
                layout = self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: cGFloat)
                layout.priority = uILayoutPriority
            case .centerX(let cGFloat, let uILayoutPriority):
                layout = self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: cGFloat)
                layout.priority = uILayoutPriority
            case .centerY(let cGFloat, let uILayoutPriority):
                layout = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: cGFloat)
                layout.priority = uILayoutPriority
            }
            layout.isActive = true
        }
    }
    
    @discardableResult
    func pin(side: Side,to viewSide: ViewSide, isActivate: Bool = true) -> NSLayoutConstraint? {
        let layout: NSLayoutConstraint?
        switch (side, viewSide) {
        case (.top(let constant, let uILayoutPriority), .top(let view)):
            layout = self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.top(let constant, let uILayoutPriority), .bottom(let view)):
            layout = self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.bottom(let constant, let uILayoutPriority), .top(let view)):
            layout = self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.bottom(let constant, let uILayoutPriority), .bottom(let view)):
            layout = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.left(let constant, let uILayoutPriority), .right(let view)):
            layout = self.leftAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.left(let constant, let uILayoutPriority), .left(let view)):
            layout = self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.right(let constant, let uILayoutPriority), .right(let view)):
            layout = self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        case (.right(let constant, let uILayoutPriority), .left(let view)):
            layout = self.rightAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
            layout?.priority = uILayoutPriority
        default:
            print("ERROR IN SET CONSTRAINT")
            return nil
        }
        layout?.isActive = isActivate
        return layout
    }
    
    func setDemission(_ demission: Demission) {
        switch demission {
        case .height(let constant):
            self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        case .width(let constant):
            self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    func setEqualSize(constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func equal(_ demission: Demission, to view: UIView) {
        switch demission {
        case .height(let constant):
            self.heightAnchor.constraint(equalTo: view.heightAnchor, constant: constant).isActive = true
        case .width(let constant):
            self.widthAnchor.constraint(equalTo: view.widthAnchor, constant: constant).isActive = true
        }
    }
}


extension UIView {
    
    // MARK: - Side cases
    
    enum Side {
        
        // MARK: - Instance Properties
        
        static let allSides: [Side] = [Side.topR, Side.bottomR, Side.leftR, Side.rightR]
        
        static let topR: Side = .top(0, .required)
        static let bottomR: Side = .bottom(0, .required)
        static let rightR: Side = .right(0, .required)
        static let leftR: Side = .left(0, .required)
        static let centerXR: Side = .centerX(0, .required)
        static let centerYR: Side = .centerY(0, .required)
        
        static let topH: Side = .top(0, .defaultHigh)
        static let bottomH: Side = .bottom(0, .defaultHigh)
        static let rightH: Side = .right(0, .defaultHigh)
        static let leftH: Side = .left(0, .defaultHigh)
        static let centerXH: Side = .centerX(0, .defaultHigh)
        static let centerYH: Side = .centerY(0, .defaultHigh)
        
        static let topL: Side = .top(0, .defaultLow)
        static let bottomL: Side = .bottom(0, .defaultLow)
        static let rightL: Side = .right(0, .defaultLow)
        static let leftL: Side = .left(0, .defaultLow)
        static let centerXL: Side = .centerX(0, .defaultLow)
        static let centerYL: Side = .centerY(0, .defaultLow)
        
        static let top: (CGFloat) -> Side = { value in
            return .top(value, .required)
        }
        
        static let bottom: (CGFloat) -> Side = { value in
            return .bottom(value, .required)
        }
        
        static let left: (CGFloat) -> Side = { value in
            return .left(value, .required)
        }
        
        static let right: (CGFloat) -> Side = { value in
            return .right(value, .required)
        }
        
        static let centerX: (CGFloat) -> Side = { value in
            return .centerX(value, .required)
        }
        
        static let centerY: (CGFloat) -> Side = { value in
            return .centerY(value, .required)
        }
        
        case top(CGFloat,UILayoutPriority)
        case bottom(CGFloat,UILayoutPriority)
        case left(CGFloat,UILayoutPriority)
        case right(CGFloat,UILayoutPriority)
        case centerX(CGFloat,UILayoutPriority)
        case centerY(CGFloat,UILayoutPriority)
    
    }
    
    // MARK: - Demission cases
    
    enum Demission {
        static let height: Demission = .height(0)
        static let width: Demission = .width(0)
        
        case height(CGFloat)
        case width(CGFloat)
    }
    
    // MARK: - ViewSide cases
    
    enum ViewSide {
        case top(UIView)
        case bottom(UIView)
        case left(UIView)
        case right(UIView)
    }
}
