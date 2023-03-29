//
//  Extension+UIColor.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        let r: CGFloat
        let g: CGFloat
        let b: CGFloat
        let a: CGFloat
       
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            var hexColor = String(hex[start...])

            if hexColor.count == 6 {
                hexColor.append("FF")
            }

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x0000_00FF) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }

    var hex: String {
        var r = CGFloat.zero
        var g = CGFloat.zero
        var b = CGFloat.zero
        var a = CGFloat.zero

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb = Int(r * 255) << 16 | Int(g * 255) << 8 | Int(b * 255) << 0

        return String(format: "#%06x", rgb)
    }
}
