//
//  ElementModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

struct ElementModel {
    let id = UUID().uuidString
    
    let type: ElementsType
    
    var parametrs = ConfigParametrModel.allCases
    
    mutating func getUIProection(parentView: ParentView, output: SelectElementOutput?) -> UIView {
        switch type {
        case .window:
            let view = DragableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView, selectOutput: output)
            self.parametrs = [
                .backgroundColor(.gray),
                .radius(8)
            ]
            view.configure(with: parametrs)
            return view
            
        case .tableView:
            let view = DragableTableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView, selectOutput: output)
            view.backgroundColor = .green
            return view
            
        case .button:
            let view =  DragableButton(frame: CGRect(x: 200, y: 400, width: 450, height: 100),
                                       model: self,
                                       parentView: parentView,
                                       selectOutput: output)
            self.parametrs = [
                .backgroundColor(.gray),
                .title("Some Text ..."),
                .radius(8)
            ]
            view.configure(with: parametrs)
            return view
            
        case .textField:
            let view = DragableTextField(frame: CGRect(x: 200, y: 400, width: 450, height: 100), parentView: parentView, selectOutput: output)
            
            self.parametrs = [
                .backgroundColor(.gray),
                .title("Some Text ..."),
                .radius(8)
            ]
            view.configure(with: parametrs)
            return view
            
        case .image:
            let view = DragableImageView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView, selectOutput: output)
            view.backgroundColor = .blue
            return view
            
        case .label:
            let view = DragableLabel(frame: CGRect(x: 200, y: 400, width: 450, height: 100), parentView: parentView, selectOutput: output)
            
            self.parametrs = [
                .backgroundColor(.gray),
                .title("Some Text ..."),
                .radius(8)
            ]
            view.configure(with: parametrs)
            
            return view
        }
    }
}
