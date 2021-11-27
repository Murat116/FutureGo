//
//  ControllerModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import Foundation

struct ControllerModel {
    let id: Int
    let name: String
    var elements: [ElementsType]
    
    static let testItems = [
        ControllerModel(id: 1, name: "one", elements: [.button, .image]),
        ControllerModel(id: 2, name: "second", elements: [.label, .tableView]),
        ControllerModel(id: 3, name: "third", elements: [.textField, .window]),
        ControllerModel(id: 4, name: "fourth", elements: [.button, .image])
    ]
}
