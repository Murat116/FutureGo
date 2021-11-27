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
        
    }
}

class ConfigComponentElementView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
    }
}
