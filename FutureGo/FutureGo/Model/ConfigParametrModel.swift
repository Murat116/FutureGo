//
//  ConfigParametrModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

enum ConfigParametrModel: Equatable {
    case title(String?)
    case textColor(UIColor?)
    case backgroundColor(UIColor?)
    case radius(CGFloat?)
    case backgroundImage(UIImage?)
    case action(String?)
    case duration(CGFloat?)
    
    var name: String {
        switch self {
        case .title:
            return "Текст"
        case .textColor:
            return "Цвет текста"
        case .backgroundColor:
            return "Цвет фона"
        case .radius:
            return "Радиус"
        case .backgroundImage:
            return "Фоновая картинка"
        case .duration:
            return "Скорость анимации"
        case .action:
            return "Действие"
        }
    }
    
    static var allCases: [ConfigParametrModel] {
        return [
            .title(nil),
            .textColor(nil),
            .backgroundColor(nil),
            .radius(nil),
            .backgroundImage(nil),
            .duration(nil),
            .action(nil)
        ]
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch lhs {
        case .title(_):
            switch rhs {
            case .title(_):
                return true
            default:
                return false
            }
        case .textColor(_):
            switch rhs {
            case .textColor(_):
                return true
            default:
                return false
            }
        case .backgroundColor(_):
            switch rhs {
            case .backgroundColor(_):
                return true
            default:
                return false
            }
        case .radius(_):
            switch rhs {
            case .radius(_):
                return true
            default:
                return false
            }
        case .backgroundImage(_):
            switch rhs {
            case .backgroundImage(_):
                return true
            default:
                return false
            }
        case .duration(_):
            switch rhs {
            case .duration(_):
                return true
            default:
                return false
            }
        case .action(_):
            switch rhs {
            case .action(_):
                return true
            default:
                return false
            }
        }
    }
}
