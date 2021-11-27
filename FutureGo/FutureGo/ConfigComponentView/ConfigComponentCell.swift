//
//  ConfigComponentCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

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
        contentView.addSubview(configView)
        
        configView.pinToSuperView(sides: [.leftR, .rightR, .topR])
        contentView.pin(side: .bottomR, to: .bottom(configView))
    }
    
    func configure(with model: ConfigParametrModel) {
        configView.configure(with: model)
    }
}

class ConfigComponentElementView: UIView {
    
    let nameLabel = UILabel()
    let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(nameLabel)
        nameLabel.pinToSuperView(sides: [.top(10, .required), .left(10, .required)])
        
        addSubview(valueLabel)
        valueLabel.pinToSuperView(sides: [.top(10), .right(-10)])
        valueLabel.pin(side: .left(10), to: .right(nameLabel))
        
        pin(side: .bottom(10), to: .bottom(nameLabel))
    }
    
    func configure(with model: ConfigParametrModel) {
        nameLabel.text = model.name
        valueLabel.text = ""
    }
}
