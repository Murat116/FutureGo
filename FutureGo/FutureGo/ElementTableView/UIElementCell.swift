//
//  UIElementCell.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

class UIElementCell: UITableViewCell{
    
    let elView = ElementView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(elView)
        self.elView.pinToSuperView(sides: [.top(8), .bottom(-8), .left(23)])
        self.layer.cornerRadius = 8
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with elemetnt: ElementsType) {
        elView.configure(with: elemetnt)
    }
    
}

extension UIElementCell {
    class ElementView: UIView {
        let imageView = UIImageView()
        let label = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setUp() {
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor(hex: "#4E4C4C")
            
            addSubview(imageView)
            imageView.pinToSuperView(sides: [.topR])
            imageView.setDemission(.height(32))
            imageView.setDemission(.width(32))
            
            addSubview(label)
            label.pinToSuperView(sides: [.centerYR])
            label.pin(side: .left(11), to: .right(imageView))
            
            pin(side: .bottomR, to: .bottom(imageView))
        }
        
        func configure(with model: ElementsType) {
            imageView.image = model.icon
            label.text = model.title
        }
    }
}
