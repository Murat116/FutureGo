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
                
                var title: String?
                var textColor: String?
                var backgroundColor: String?
                var radius: CGFloat?
                var backgroundImage: String?
                var action: String?
                var duration: CGFloat?
                
                parametrs.forEach { parametrDict in
                    title = parametrDict["title"] as? String
                    textColor = parametrDict["textColor"] as? String
                    backgroundColor = parametrDict["backgroundColor"] as? String
                    radius = parametrDict["radius"] as? CGFloat
                    backgroundImage = parametrDict["backgroundImage"] as? String
                    action = parametrDict["action"] as? String
                    duration = parametrDict["duration"] as? CGFloat
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
