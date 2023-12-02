//
//  HexColorFile.swift
//  NewsApp
//
//  Created by Seher Köse on 6.09.2023.
//

import UIKit
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = String(hex.dropFirst())
        }
        
        assert(hexWithoutSymbol.count == 6, "Invalid hex code used.")
        
        var rgb: UInt64 = 0
        Scanner(string: hexWithoutSymbol).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
