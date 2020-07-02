//
//  AppFonts.swift
//  Components
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

enum AppFonts {
    static let bold = "PollyRounded-Bold"
    static let light = "PollyRounded-Light"
    static let regular = "PollyRounded-Regular"
    static let thin = "PollyRounded-Thin"
}

extension UIFont {
    func appFont(size: CGFloat, weigth: UIFont.Weight) -> UIFont {
        
        let font: UIFont?
        switch weigth {
        case .bold: font = UIFont(name: AppFonts.bold, size: size)
        case .light: font = UIFont(name: AppFonts.light, size: size)
        case .thin: font = UIFont(name: AppFonts.thin, size: size)
        default: font = UIFont(name: AppFonts.regular, size: size)
        }
        
        return font ?? UIFont.systemFont(ofSize: size)
        
    }
}
