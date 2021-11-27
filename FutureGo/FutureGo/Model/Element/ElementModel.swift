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
    
    func getParametrs() -> [ConfigParametrModel] {
        return ConfigParametrModel.allCases
//        switch type {
//        case .window:
//            return []
//        case .tableView:
//            return []
//        case .button:
//            return []
//        case .textField:
//            return []
//        case .image:
//            return []
//        case .label:
//            return [.title(nil), .textColor(nil)]
//        }
    }
    
    func getUIProection(parentView: UIView, output: SelectElementOutput?) -> UIView {
        switch type {
        case .window:
            let view = DragableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .lightGray
            return view
            
        case .tableView:
            let view = DragableTableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .green
            return view
            
        case .button:
            let view =  DragableButton(frame: CGRect(x: 200, y: 400, width: 400, height: 400),
                                       model: self,
                                       parentView: parentView,
                                       selectOutput: output)
            view.backgroundColor = .darkText
            return view
            
        case .textField:
            let view = DragableTextField(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .red
            return view
            
        case .image:
            let view = DragableImageView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .blue
            return view
            
        case .label:
            let view = DragableLabel(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .yellow
            return view
        }
    }
}
