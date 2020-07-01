//
//  BaseController.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

public class BaseController: UIViewController {
    private lazy var errorView = ErrorView() >> { $0.delegate = self }
    private let loadingView = LoadingView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(errorView)
        view.addSubview(loadingView)
    }
    
    func layout(_ display: Display<Any>) {
        errorView.layout(display)
        loadingView.layout(display)
    }
}

extension BaseController: ErrorViewDelegate {
    func didPressExit() {
        guard let navigation = navigationController else {
            dismiss(animated: true, completion: nil)
            return
        }
        navigation.dismiss(animated: true, completion: nil)
    }
}
