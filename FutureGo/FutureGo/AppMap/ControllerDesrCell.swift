//
//  ControllerDesrCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ControllerDesrCell: UITableViewCell {
    
    let nameLabel = UILabel()
    
    let elementsStack = UIStackView()
    
    var stackHidden = false
    
    var bottomCellConstrToStack: NSLayoutConstraint?
    var bottomCellConstrToName: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        selectionStyle = .none
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap)))
        contentView.clipsToBounds = true
        
        contentView.addSubview(nameLabel)
        nameLabel.pinToSuperView(sides: [.leftR, .topR, .rightR])
        
        elementsStack.axis = .vertical
        elementsStack.distribution = .fill
        elementsStack.spacing = 3
        elementsStack.alignment = .leading
        
        contentView.addSubview(elementsStack)
        elementsStack.pin(side: .top(5), to: .bottom(nameLabel))
        elementsStack.pin(side: .left(10), to: .left(nameLabel))
        elementsStack.pinToSuperView(sides: [.rightR])
        
        bottomCellConstrToStack = contentView.pin(side: .bottomR, to: .bottom(elementsStack))
        bottomCellConstrToName = contentView.pin(side: .bottomR, to: .bottom(nameLabel), isActivate: false)
    }
    
    func configure(with model: ControllerModel) {
        nameLabel.text = model.name
        
        elementsStack.arrangedSubviews.forEach {
            elementsStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        
        model.elements.forEach { element in
            let lbl = UILabel()
            lbl.text = element.type.title
            elementsStack.addArrangedSubview(lbl)
        }
    }
    
    @objc private func tap() {
        stackHidden = !stackHidden
        if stackHidden {
            bottomCellConstrToStack?.isActive = false
            bottomCellConstrToName?.isActive = true
        } else {
            bottomCellConstrToStack?.isActive = true
            bottomCellConstrToName?.isActive = false
        }
    }
}
