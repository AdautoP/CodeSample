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
    
    private let feedbackView = ImageFeedbackView()
    
    private lazy var exitButton = UIButton() >> {
        $0.setTitle("Sair", for: .normal)
        $0.addTarget(self, action: #selector(exit), for: .touchUpInside)
        
    }
    
    private lazy var retryButton = UIButton(type: .system) >> {
        $0.titleLabel?.font = .appFont(size: 16, weight: .regular)
        $0.setTitle("Tentar novamente", for: .normal)
        $0.backgroundColor = AppColors.Interface.yellow
        $0.setTitleColor(AppColors.Grays.black, for: .normal)
        $0.layer.cornerRadius = 16
        $0.contentEdgeInsets = .horizontal(8)
        $0.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }
    
    private var retryAction: (() -> Void)?
    
    override init() {
        super.init()
        alpha = 0
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        retryButton.height(48)
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
            .contentView(feedbackView),
            retryAction != nil ? .button(retryButton) : nil
        )
        feedbackView.layout(retryAction != nil)
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
