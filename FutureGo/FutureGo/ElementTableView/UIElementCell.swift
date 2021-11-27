//
//  UIElementCell.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

class UIElementCell: UITableViewCell{
    
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(title)
        self.title.pinToSuperView(sides: [.top(16), .bottom(16), .left(16)])
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.title.text = title
    }
    
}
