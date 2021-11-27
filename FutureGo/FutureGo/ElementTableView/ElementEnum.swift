//
//  ElementEnum.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import Foundation
import UIKit

enum ElementsType: CaseIterable {
    case window
    case tableView
    case button
    case textField
    case image
    case label
    
    var title: String {
        switch self {
        case .window:
            return "Окно"
        case .tableView:
            return "Табличное представление"
        case .button:
            return "Кнопка"
        case .textField:
            return "Текстовое поле"
        case .image:
            return "Картинка"
        case .label:
            return "Лейбл"
        }
    }
    
    func getUIProection(parentView: ParentView) -> UIView {
        switch self {
        case .window:
            let view = DragableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .lightGray
            return view
            
        case .tableView:
            let view = DragableTableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
            view.backgroundColor = .green
            return view
            
        case .button:
            let view =  DragableButton(frame: CGRect(x: 200, y: 400, width: 400, height: 400), parentView: parentView)
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
    
    func gerRealElement() -> UIView {
        switch self {
        case .window:
            let view = UIView(frame: CGRect(x: 200, y: 400, width: 400, height: 400))
            view.backgroundColor = .lightGray
            return view
        case .tableView:
            let view = UITableView(frame: CGRect(x: 200, y: 400, width: 400, height: 400))
            view.backgroundColor = .brown
            return view
        case .button:
            let view = UIButton(frame: CGRect(x: 200, y: 400, width: 400, height: 400))
            view.backgroundColor = .yellow
            return view
        case .textField:
            let view = UITextField(frame: CGRect(x: 200, y: 400, width: 400, height: 400))
            view.backgroundColor = .red
            return view
        case .image:
            let view = UIImageView(frame: CGRect(x: 200, y: 400, width: 400, height: 400))
            view.backgroundColor = .green
            return view
        case .label:
            let view = UILabel(frame: CGRect(x: 200, y: 400, width: 400, height: 400))
            view.backgroundColor = .blue
            return view
        }
    }
}