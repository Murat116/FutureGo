//
//  extensionUIColor.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexFormatted: String =  hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        var alpha: CGFloat = 1.0
        var rgbValue: UInt64 = 0
        
        if hex.count > 7 && hex != "#NNNNNN00" {
            alpha = CGFloat(Float(hex.suffix(2)) ?? 100) / 100
            hexFormatted = String(hexFormatted.dropLast(2))
        }
        
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    var hex: String {
        let colorRef = self.cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha

        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )

        if a != 1 {
            color += String(Int(a * 100))
        }

        return color
    }
}
