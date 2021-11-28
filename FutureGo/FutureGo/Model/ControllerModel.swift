//
//  ControllerModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import Foundation

struct CControllerModel: Codable {
//    var id: String = UUID().uuidString
    var name: String = ""
}

struct ControllerModel: Codable {
    var id: String = UUID().uuidString
    let name: String
    var elements: [ElementModel]
}
