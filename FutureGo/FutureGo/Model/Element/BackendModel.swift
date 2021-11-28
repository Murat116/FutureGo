//
//  BackendModel.swift
//  FutureGo

import Foundation
import UIKit

class MyModel {
    internal init(title: String,upString: String, price: String, graphic: UIImage? = nil) {
        self.title = title
        self.price = price
        self.graphic = graphic
        self.upString = upString
    }
    
    var title: String
    var upString: String
    var price: String
    var graphic: UIImage?
    
    static var model = [
        MyModel(title: "Ford",upString: "54.18%", price: "19.68 $", graphic: UIImage(named: "img1")),
        MyModel(title: "SPB биржа",upString: "9,16%",price: "13,81 $", graphic: UIImage(named: "img2")),
        MyModel(title: "virdgin Galactic",upString: "-34,62%", price: "16.71$", graphic: UIImage(named: "img3")),
        MyModel(title: "VIP Shop",upString: "-57,31%", price: "9.82 $", graphic: UIImage(named: "img4")),
        MyModel(title: "Alibaba",upString: "-36,84%", price: "133.1$", graphic: UIImage(named: "img5")),
        MyModel(title: "Газпром нефть",upString: "30,32%", price: "491 R", graphic: UIImage(named: "img6")),
        MyModel(title: "VISA", upString: "-13,7%",price: "197,5", graphic: UIImage(named: "img7")),
        MyModel(title: "Southwestern Enregy",upString: "-3,69%", price: "4,94 $", graphic: UIImage(named: "img1")),
        MyModel(title: "NOKIA",upString: "11%", price: "5,6 $", graphic: UIImage(named: "img1")),
        MyModel(title: "TSM",upString: "2,46%", price: "161,88 $", graphic: UIImage(named: "img1")),
        MyModel(title: "TAL",upString: "-87,87%", price: "5.03 $", graphic: UIImage(named: "img1")),
        MyModel(title: "Газпром",upString: "-25,38%", price: "326Р", graphic: UIImage(named: "img1")),
        MyModel(title: "EUR",upString: "-5,04%", price: "85,5 R ", graphic: UIImage(named: "img1")),
        MyModel(title: "SNAP INC",upString: "-15,87%", price: "49,76", graphic: UIImage(named: "img1")),
        MyModel(title: "Microsoft",upString: "30,97%", price: "329,85", graphic: UIImage(named: "img1")),
        MyModel(title: "Apple",upString: "23,57%", price: "157,15", graphic: UIImage(named: "img1")),
        MyModel(title: "Hugo Boss", upString: "14,29%",price: "52,2 E", graphic: UIImage(named: "img1")),
        MyModel(title: "Yandex",upString: "9,79%", price: "5 387 P", graphic: UIImage(named: "img1")),
    ]
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
