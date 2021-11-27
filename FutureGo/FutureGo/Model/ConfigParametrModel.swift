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
    case action(Selector?)
    
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
            .action(nil)
        ]
    }
}
