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
    var elements: [ElementsType]
}
