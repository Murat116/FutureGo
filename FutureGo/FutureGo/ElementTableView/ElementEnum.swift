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
    
    var element: UIView {
        switch self {
        case .window:
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            view.backgroundColor = .lightGray
            return view
        case .tableView:
            return UITableView()
        case .button:
            return UIButton()
        case .textField:
            return UITextField()
        case .image:
            return UIImageView()
        case .label:
            return UILabel()
        }
    }
}
