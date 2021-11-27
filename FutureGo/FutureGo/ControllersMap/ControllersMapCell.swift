//
//  ControllersMapCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ControllersMapCell: UICollectionViewCell {
    
    let mainView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        mainView.backgroundColor = .red
        
        contentView.addSubview(mainView)
        
        mainView.pinToSuperView(sides: [.top(50, .required), .right(-50, .required), .left(50, .required), .bottom(-50, .required)])
    }
    
    func configure(with model: ControllerModel) {
        
    }
}
