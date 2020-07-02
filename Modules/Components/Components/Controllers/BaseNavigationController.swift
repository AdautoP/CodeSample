//
//  BaseNavigationController.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

public class BaseNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationBar.shadowImage = nil
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.isTranslucent = false
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
