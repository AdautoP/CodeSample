//
//  UIBarButtonItem+Ext.swift
//  Components
//
//  Created by Adauto Pinheiro on 07/07/20.
//

import UIKit

public extension UIBarButtonItem {
    static func setAppAppearance() {
        Self.appearance(whenContainedInInstancesOf: [UISearchBar.self, UIView.self]).setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.appFont(size: 16, weight: .regular)],
            for: .normal
        )
    }
}
