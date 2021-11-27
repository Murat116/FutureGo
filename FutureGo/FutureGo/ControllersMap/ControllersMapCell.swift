//
//  ControllersMapCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit


protocol ControllersMapCellOutput: AnyObject {
    func removewFromSuperview(model: ControllerModel, element: ElementsType)
}

class ControllersMapCell: UICollectionViewCell, ParentView {
    let mainView = UIView()
    public weak var output: ControllersMapCellOutput?
    
    public var model: ControllerModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        mainView.backgroundColor = .white
        
        contentView.addSubview(mainView)
        
        mainView.pinToSuperView(sides: [.top(50, .required), .right(-50, .required), .left(50, .required), .bottom(-50, .required)])
    }
    
    func configure(with model: ControllerModel, parent: ControllersMapCellOutput) {
        self.output = parent
        self.model = model
    }
    
    func removewFromSuperview(type: ElementsType) {
        self.output?.removewFromSuperview(model: self.model!, element: type)
    }
    
}
