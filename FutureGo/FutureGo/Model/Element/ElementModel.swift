//
//  ElementModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ElementModel {
    internal init(type: ElementsType, frame: CGRect) {
        self.type = type
        self.frame = frame
    }
    

    var id = UUID().uuidString
    
    let type: ElementsType
    
    var frame: CGRect
    
    func changeFrame(frame: CGRect) {
        self.frame = frame
    }
    
    var parametrs = ConfigParametrModel.allCases
    
    func getUIProection(parentView: ParentView, output: SelectElementOutput?, id: String) -> UIView {
        switch type {
        case .window:
            let view = DragableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), model: self, parentView: parentView, id: id, selectOutput: output)
            self.parametrs = [
                .backgroundColor(.gray),
                .radius(8)
            ]
            view.configure(with: parametrs)
            return view
            
        case .tableView:
            let view = DragableTableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView, id: id, selectOutput: output)
//            view.backgroundColor = .green
            return view
            
        case .button:
            let view =  DragableButton(frame: CGRect(x: 200, y: 400, width: 450, height: 100),
                                       model: self,
                                       parentView: parentView,
                                       selectOutput: output, id: id)
            
            self.parametrs = [
                .backgroundColor(.gray),
                .title("Some Text ..."),
                .radius(8)
            ]
            view.configure(with: parametrs)
            return view
            
        case .textField:
            let view = DragableTextField(frame: CGRect(x: 200, y: 400, width: 400, height: 400), model: self, parentView: parentView, id: id, selectOutput: output)
            
            self.parametrs = [
                .backgroundColor(.gray),
                .textColor(.black),
                .title("Some Text ..."),
                .radius(8)
            ]
            view.configure(with: parametrs)
            return view
            
        case .image:
            let view = DragableImageView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), model: self, parentView: parentView, id: id, selectOutput: output)
            view.backgroundColor = .gray
            
            self.parametrs = [
                .backgroundImage(nil),
                .radius(8)
            ]
            view.configure(with: parametrs)
            
            return view
            
        case .label:
            let view = DragableLabel(frame: CGRect(x: 200, y: 400, width: 400, height: 400), model: self, parentView: parentView, id: id, selectOutput: output)
            
            self.parametrs = [
                .backgroundColor(.gray),
                .title("Some Text ..."),
                .radius(8)
            ]
            view.configure(with: parametrs)
            
            return view
        }
    }
    
    func gerRealElement(model: ElementModel) -> UIView {
        switch self.type {
        case .window:
            let view = UIView(frame: self.frame)
            view.backgroundColor = .lightGray
            return view
        case .tableView:
            let view = UITableView(frame: self.frame)
            view.backgroundColor = .brown
            return view
        case .button:
            let view = UIButton(frame: self.frame)
            for parameter in model.parametrs {
                switch parameter {
                case .title(let optional):
                    view.setTitle(optional, for: .normal)
                case .textColor(let optional):
                    view.setTitleColor(optional, for: .normal)
                case .backgroundColor(let optional):
                    view.backgroundColor = optional
                case .radius(let optional):
                    view.layer.cornerRadius = optional ?? 0
                case .backgroundImage(let optional):
                    view.setImage(optional, for: .normal)
                case .action(let optional):
//                    view.
                    print("cvbn")
                    break
                }
            }
//            view.backgroundColor = model.parametrs.firstIndex(of: $0 == .backgroundColor)
//            view.backgroundColor = model.parametrs.firstIndex(of: $0 == .backgroundColor)
//            view.backgroundColor = model.parametrs.firstIndex(of: $0 == .backgroundColor)
//            view.backgroundColor = model.parametrs.firstIndex(of: $0 == .backgroundColor)
            
            return view
        case .textField:
            let view = UITextField(frame: self.frame)
            view.backgroundColor = .red
            return view
        case .image:
            let view = UIImageView(frame: self.frame)
            view.backgroundColor = .green
            return view
        case .label:
            let view = UILabel(frame: self.frame)
            view.backgroundColor = .blue
            return view
        }
    }
}
