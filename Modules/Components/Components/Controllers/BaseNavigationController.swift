//
//  BaseNavigationController.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

public class BaseNavigationController: UINavigationController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        navigationBar.tintColor = AppColors.Grays.black
        navigationBar.setBackgroundImage(nil, for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        view.backgroundColor = AppColors.Grays.lightGray

    }
    
    @available(*, unavailable)
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
