//
//  ControllerModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import Foundation

struct ControllerModel {
    let id: String = UUID().uuidString
    let name: String
    var elements: [ElementModel]
    
    static let testItems = [
        ControllerModel(id: 1, name: "one", elements: [ElementModel(type: .button), ElementModel(type: .image)]),
        ControllerModel(id: 2, name: "second", elements: [ElementModel(type: .label), ElementModel(type: .tableView)]),
        ControllerModel(id: 3, name: "third", elements: [ElementModel(type: .textField), ElementModel(type: .window)]),
        ControllerModel(id: 4, name: "fourth", elements: [ElementModel(type: .button), ElementModel(type: .image)])
    ]
}
