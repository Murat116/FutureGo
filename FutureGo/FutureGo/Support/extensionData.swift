//
//  extensionData.swift
//  FutureGo
//
//  Created by Roman Shurkin on 28.11.2021.
//

import Foundation

extension Data {
    
    
    var jsonArray: [Any]? {
        guard self.count > 0 else { return [Any]() }
        do {
            return try JSONSerialization.jsonObject(with: self ) as? [Any]
        } catch {
            return nil
        }
    }
}

extension Dictionary {
    
    var jsonString: String? {
        guard let jsonData = self.jsonData else { return nil }
        return String(bytes: jsonData, encoding: .utf8)
    }

   
}

extension Array {
    
    var jsonData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self )
        } catch {
            print(error)
            return nil
        }
    }
}