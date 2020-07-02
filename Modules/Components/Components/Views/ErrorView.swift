//
//  ErrorView.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didPressExit()
}

public class ErrorView: ScreenView {
    weak var delegate: ErrorViewDelegate?
    
    private let imageView = UIImageView() >> {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var exitButton = UIButton() >> {
        $0.setTitle("Sair", for: .normal)
        $0.addTarget(self, action: #selector(exit), for: .touchUpInside)
        
    }
    
    private lazy var retryButton = UIButton() >> {
        $0.setTitle("Tentar novamente", for: .normal)
        $0.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }
    
    private var retryAction: (() -> Void)?
    
    override init() {
        super.init()
        alpha = 0
    }
    
    public func layout<T>(_ display: Display<T>) {
        switch display {
        case let .failure(_, retryAction): layoutError(retryAction)
        default: animateOut()
        }
    }
    
    private func layoutError(_ retryAction: (() -> Void)?) {
        self.retryAction = retryAction
        render(
            .contentView(imageView),
            .button(exitButton),
            retryAction != nil ? .button(retryButton) : nil
        )
        animateIn()
    }
    
    private func animateIn() {
        UIView.animate(
        withDuration: 0.2,
        animations: { self.alpha = 1 }
        )
        
    }
    
    private func animateOut() {
        UIView.animate(
            withDuration: 0.2,
            animations: { self.alpha = 0 }
        )
    }
    
    @objc private func retry() {
        retryAction?()
    }
    
    @objc private func exit() {
        delegate?.didPressExit()
    }
}
