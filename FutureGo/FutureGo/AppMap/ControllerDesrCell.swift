//
//  ControllerDesrCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ControllerDesrCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        return lbl
    }()
    
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
        nameLabel.pinToSuperView(sides: [.left(34), .top(47), .rightR])
        
        elementsStack.axis = .vertical
        elementsStack.distribution = .fill
        elementsStack.spacing = 12
        elementsStack.alignment = .leading
        
        contentView.addSubview(elementsStack)
        elementsStack.pin(side: .top(18), to: .bottom(nameLabel))
        elementsStack.pinToSuperView(sides: [.left(34), .rightR])
        
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
            lbl.font = .systemFont(ofSize: 16)
            lbl.textColor = UIColor(hex: "#4E4C4C")
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
