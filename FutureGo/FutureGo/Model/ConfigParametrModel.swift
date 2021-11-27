//
//  ConfigParametrModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

struct ConfigParametrModel {
    let name: String
    let value: CGFloat
    
    static let testElements = [
        ConfigParametrModel(name: "name", value: 1),
        ConfigParametrModel(name: "color", value: 2),
        ConfigParametrModel(name: "corner", value: 8),
        ConfigParametrModel(name: "shadow", value: 3),
    ]
}
