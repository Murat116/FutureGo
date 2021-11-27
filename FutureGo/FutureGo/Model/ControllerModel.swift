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
    
    static let testItems = [
        ControllerModel(id: 1, name: "one"),
        ControllerModel(id: 2, name: "second"),
        ControllerModel(id: 3, name: "third"),
        ControllerModel(id: 4, name: "fourth")
    ]
}
