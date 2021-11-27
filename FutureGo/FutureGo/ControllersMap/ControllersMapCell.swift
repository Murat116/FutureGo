//
//  ControllersMapCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit


protocol ControllersMapCellOutput: AnyObject {
    func removewFromSuperview(model: ControllerModel, element: ElementsType)
    func changeModelOf(model: ControllerModel?)
}

class ControllersMapCell: UICollectionViewCell, ParentView {
    let mainView = UIView()
    public weak var output: ControllersMapCellOutput?
    
    var controllerModel: ControllerModel?
    
    weak var selectOutput: SelectElementOutput?
    
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
    
    func configure(with model: ControllerModel, output: ControllersMapCellOutput?, selectOutput: SelectElementOutput?) {
        self.controllerModel = model
        self.selectOutput = selectOutput
        self.output = output
    }
    
    func addElement(_ element: ElementModel) {
        guard var model = controllerModel else {
            return
        }
        
        let view = element.getUIProection(parentView: self, output: selectOutput, id: element.id)
        
        model.elements.append(element)
        controllerModel = model
        
        addSubview(view)
    }
    
    func removewFromSuperview(type: ElementsType) {
        self.output?.removewFromSuperview(model: self.controllerModel!, element: type)
    }
    
    func changeFrame(of: Dragable, to new: CGRect) {
        self.controllerModel?.elements.first{$0.id == of.id}?.changeFrame(frame: new)
        self.output?.changeModelOf(model: self.controllerModel)
    }
        
}
