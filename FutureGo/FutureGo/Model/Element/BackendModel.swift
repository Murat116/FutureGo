//
//  BackendModel.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/28/21.
//

import Foundation
import UIKit

class MyModel {
    var title: String = ""
    var price: String = ""
    var graphic: UIImage? = nil
    
    static var model = [MyModel]()
}



class BackendModel {
    internal init(key: String, value: Any?, type: ValueTypes) {
        self.key = key
        self.value = value
        self.type = type
    }
    
    var key: String
    var value: Any?
    
    var type: ValueTypes
    
    static var globalModel = [[BackendModel]]()
    
    static var testModel: [BackendModel] =
         [
            BackendModel(key: "Likes", value: nil, type: .int),
                BackendModel(key: "Phone", value: nil, type: .int),
                BackendModel(key: "UUID", value: nil, type: .string),
                BackendModel(key: "Insta", value: nil, type: .string),
                BackendModel(key: "Name", value: nil, type: .string),
            BackendModel(key: "Image", value: nil, type: .data)
            
         ]
    
    
    static func reqeustToTask() {
        guard let url = URL(string: "https://valentinkilar.herokuapp.com/userGet?all=1") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(dataAttay, response, error) in
            guard error == nil else {
                return
            }
            guard let data = dataAttay, let array = data.elements() else { return }
            DispatchQueue.main.async {
                
                for value in array where value is [String: Any]{
                    var arrayModel = [BackendModel]()
                    for mod in self.testModel {
                        let ara = BackendModel(key: mod.key, value: nil, type: mod.type)
                        arrayModel.append(ara)
                    }
                    guard let value = value as? [String: Any] else { continue }
                    for i in 0..<BackendModel.testModel.count {
                        let model = BackendModel.testModel[i]
                        guard let valuee = value[model.key] else { continue }
                        arrayModel[i].value = valuee
                    }
                    self.globalModel.append(arrayModel)
                }
                self.getImage()
                print(self.globalModel)
            }
        }
        
        task.resume()
    }
    
    static func getImage() {
        for model in self.globalModel {
            guard let urlImg = URL(string: "https://valentinkilar.herokuapp.com//photo?phone=\(String(model.first{$0.key == "Phone"}?.value as! Int))&get=1") else { return }
            let taskImage = URLSession.shared.dataTask(with: urlImg) {(data, response, error) in
                guard error == nil else {
                    return
                }
                
                guard let data = data else { return }
                model.first{$0.key == "Image"}?.value = data
                
                guard self.globalModel.last?[3].value as? String == model[3].value as? String else { return }
                print("mod")
            }
            
            taskImage.resume()
        }
        print("mmmm")
        
    }
}

enum ValueTypes {
    case string
    case int
    case data
    case dictionary
    case array
}



extension Data {
    
    var jsonDictionary: [String:Any]? {
        guard self.count > 0 else { return [String:Any]() }
        do {
            return try JSONSerialization.jsonObject(with: self ) as? [String:Any]
        } catch {
            return nil
        }
    }
    
    var rangeDictionary: [NSRange:String]? {
        guard self.count > 0 else { return [NSRange:String]() }
        do {
            return try JSONSerialization.jsonObject(with: self ) as? [NSRange:String]
        } catch {
            return nil
        }
    }
}

extension Dictionary{
    var jsonData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self )
        } catch {
            return nil
        }
    }
}

extension Data {
    func elements () -> [Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: []) as? [Any]
    }
}
