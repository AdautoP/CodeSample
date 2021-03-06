//
//  BaseController.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

open class BaseController<Interactor, RootView: UIView>: UIViewController {
    private lazy var errorView = ErrorView() >> { $0.delegate = self }
    private let loadingView = LoadingView()
    
    public let interactor: Interactor
    public var rootView: RootView
    
    override public func loadView() {
        view = rootView
    }
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        self.rootView = RootView()
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
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [
        NSAttributedString.Key.font: UIFont.appFont(size: 24, weight: .bold)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.appFont(size: 32, weight: .bold)
        ]
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isTranslucent = true
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
