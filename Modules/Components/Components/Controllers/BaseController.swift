//
//  BaseController.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

open class BaseController: UIViewController {
    private lazy var errorView = ErrorView() >> { $0.delegate = self }
    private let loadingView = LoadingView()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(errorView)
        view.addSubview(loadingView)
        
        errorView.edgesToSuperview()
        loadingView.edgesToSuperview()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = AppColors.Grays.black
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.appFont(size: 32, weight: .bold)
        ]
    }
    
    open func layout<T>(_ display: Display<T>) {
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
