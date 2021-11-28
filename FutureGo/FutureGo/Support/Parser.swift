//
//  Parser.swift
//  FutureGo
//
//  Created by Roman Shurkin on 28.11.2021.
//

import UIKit

class Parser {
    
    func write<T: Encodable>(_ object: T) {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }
        let tmpURL = FileManager.default.temporaryDirectory.appendingPathComponent("model.json")
        print(tmpURL)
        do {
            try data.write(to: tmpURL)
        } catch {
            print(error)
        }
    }
    
    func parse() -> [ControllerModel]? {
        guard
            let data = try? Data(contentsOf: FileManager.default.temporaryDirectory.appendingPathComponent("model.json")),
            let array = data.jsonArray as? [[String : Any]]
        else { return nil }

        var models = [ControllerModel]()
        
        array.forEach { dict in
            guard
                let id = dict["id"] as? String,
                let name = dict["name"] as? String,
                let elementsDict = dict["elements"] as? [[String : Any]]
            else { return }
            
            var elements = [ElementModel]()
            
            elementsDict.forEach { elementDict in
                guard
                    let rawType = elementDict["type"] as? Int,
                    let type = ElementsType.init(rawValue: rawType),
                    let frame = elementDict["frame"] as? [[CGFloat]],
                    let parametrs = elementDict["parametrs"] as? [[String : Any]]
                else { return }
                
                let fr = CGRect(x: frame[0][0], y: frame[0][1], width: frame[1][0], height: frame[1][1])
                let element = ElementModel(type: type, frame: fr)
                
                var title: String? = nil
                var textColor: String? = nil
                var backgroundColor: String? = nil
                var radius: CGFloat? = nil
                var backgroundImage: String? = nil
                var action: String? = nil
                var duration: CGFloat? = nil
                
                parametrs.forEach { parametrDict in
                    if let t = parametrDict["title"] as? String {
                        title = t
                    }
                    if let tColor = parametrDict["textColor"] as? String {
                        textColor = tColor
                    }
                    if let bColor = parametrDict["backgroundColor"] as? String {
                        backgroundColor = bColor
                    }
                    if let r = parametrDict["radius"] as? CGFloat {
                        radius = r
                    }
                    if let bImage = parametrDict["backgroundImage"] as? String {
                        backgroundImage = bImage
                    }
                    if let ac = parametrDict["action"] as? String {
                        action = ac
                    }
                    if let dur = parametrDict["duration"] as? CGFloat {
                        duration = dur
                    }
                }
                
                let image: UIImage? = nil
//                if let data = Data(base64Encoded: backgroundImage) {
//                    image = UIImage(data: data)
//                }
                
                element.parametrs = [
                    .title(title),
                    .textColor(UIColor(hex: textColor ?? "")),
                    .backgroundColor(UIColor(hex: backgroundColor ?? "")),
                    .radius(radius),
                    .backgroundImage(image),
                    .action(action),
                    .duration(duration)
                ]
                
                elements.append(element)
            }
            
            let model = ControllerModel(id: id, name: name, elements: elements)
            models.append(model)
        }
        
        return models
    }
}
