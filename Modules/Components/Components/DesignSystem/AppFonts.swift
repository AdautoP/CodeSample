//
//  AppFonts.swift
//  Components
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

final class AppFonts {
    let files = [
        "PollyRounded-Bold.otf",
        "PollyRounded-Light.otf",
        "PollyRounded-Regular.otf",
        "PollyRounded-Thin.otf"
    ]
    
    static let bold = "PollyRounded-Bold"
    static let light = "PollyRounded-Light"
    static let regular = "PollyRounded-Regular"
    static let thin = "PollyRounded-Thin"
    
    func registerFonts() {
        let bundle = Bundle(for: AppFonts.self)
        files.forEach { self.register(filename: $0, bundle: bundle) }
    }

    private func register(filename: String, bundle: Bundle) {
        guard
            let pathForResourceString = bundle.path(forResource: filename, ofType: nil),
            let fontData = NSData(contentsOfFile: pathForResourceString),
            let dataProvider = CGDataProvider(data: fontData)
        else {
            return
        }

        _ = UIFont()

        guard let fontRef = CGFont(dataProvider) else {
            return
        }

        var errorRef: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false {}
    }
}

public extension UIFont {
    static func appFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let font: UIFont?
        switch weight {
        case .bold: font = UIFont(name: AppFonts.bold, size: size)
        case .light: font = UIFont(name: AppFonts.light, size: size)
        case .thin: font = UIFont(name: AppFonts.thin, size: size)
        default: font = UIFont(name: AppFonts.regular, size: size)
        }
        
        return font ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    static func registerFonts() {
        AppFonts().registerFonts()
    }
}
