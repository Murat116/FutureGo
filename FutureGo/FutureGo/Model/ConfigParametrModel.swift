//
//  ConfigParametrModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

enum ConfigParametrModel: Equatable, Codable {
    enum CodingKeys: CodingKey {
        case title
        case textColor
        case backgroundColor
        case radius
        case backgroundImage
        case action
        case duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first!
        
        switch key {
        case .title:
            let text = try container.decode(
                String.self,
                forKey: .title
            )
            self = .title(text)
        case .textColor:
            let hex = try container.decode(
                String.self,
                forKey: .textColor
            )
            self = .textColor(UIColor(hex: hex))
        case .backgroundColor:
            let hex = try container.decode(
                String.self,
                forKey: .backgroundColor
            )
            self = .backgroundColor(UIColor(hex: hex))
        case .radius:
            let value = try container.decode(
                Float.self,
                forKey: .radius
            )
            self = .radius(CGFloat(value))
        case .backgroundImage:
            let data = try container.decode(
                Data.self,
                forKey: .radius
            )
            self = .backgroundImage(UIImage(data: data))
        case .action:
            let id = try container.decode(
                String.self,
                forKey: .action
            )
            self = .action(id)
        case .duration:
            let value = try container.decode(
                Float.self,
                forKey: .duration
            )
            self = .radius(CGFloat(value))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .title(let text):
            try container.encode(text, forKey: .title)
        case .textColor(let color):
            try container.encode(color?.hex, forKey: .textColor)
        case .backgroundColor(let color):
            try container.encode(color?.hex, forKey: .backgroundColor)
        case .radius(let value):
            guard let value = value else { break }
            try container.encode(Float(value), forKey: .radius)
        case .backgroundImage(let image):
            try container.encode(image?.pngData(), forKey: .backgroundImage)
        case .action(let id):
            try container.encode(id, forKey: .action)
        case .duration(let value):
            guard let value = value else { break }
            try container.encode(Float(value), forKey: .duration)
        }
    }
    
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
