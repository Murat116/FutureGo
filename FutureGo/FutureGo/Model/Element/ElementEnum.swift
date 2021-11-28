//
//  ElementEnum.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import Foundation
import UIKit

enum ElementsType: Int, CaseIterable, Codable  {
    case window = 0
    case tableView
    case button
    case textField
    case image
    case label
    case swipableView
    
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
        case .swipableView:
            return "Тиндер Свайп"
        }
    }
}
