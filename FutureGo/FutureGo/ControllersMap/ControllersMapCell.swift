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
    let imageView = UIImageView()
    public weak var output: ControllersMapCellOutput?
    
    var controllerModel: ControllerModel?
    
    weak var selectOutput: SelectElementOutput?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        self.addSubview(self.imageView)
        self.imageView.pinToSuperView()
        self.imageView.image = UIImage(named: "IphoneView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
    }
    
    func configure(with model: ControllerModel, output: ControllersMapCellOutput?, selectOutput: SelectElementOutput?) {
        self.controllerModel = model
        self.update(with: model)
        self.selectOutput = selectOutput
        self.output = output
    }
    
    func update(with model: ControllerModel) {
        self.subviews.forEach { view in
            guard (view is UIImageView) == false else { return }
            view.removeFromSuperview()
        }
        model.elements.forEach { model in
            self.addElement(model, isSubView: false) //FIXME: может быть баг)))))))) РОМА СОРИ)))
            let view = model.getUIProection(parentView: self, output: selectOutput, id: model.id)
            
            self.addSubview(view)
        }
    }
    
    func addElement(_ element: ElementModel, isSubView: Bool) {
        guard var model = controllerModel else {
            return
        }
        
        let view = element.getUIProection(parentView: self, output: selectOutput, id: element.id)
        
        guard isSubView else { return }
        self.addSubview(view)
        
        guard !isSubView else { return }
//        model.elements.append(element)
//        controllerModel = model
        
    }
    
    func removewFromSuperview(type: ElementsType) {
        self.output?.removewFromSuperview(model: self.controllerModel!, element: type)
    }
    
    func changeFrame(of: Dragable, to new: CGRect) {
        self.controllerModel?.elements.first{$0.id == of.id}?.changeFrame(frame: new)
        self.controllerModel?.elements.forEach{
            $0.subview.first{$0.id == of.id}?.changeFrame(frame: new)
        }
        self.output?.changeModelOf(model: self.controllerModel)
    }
        
}
