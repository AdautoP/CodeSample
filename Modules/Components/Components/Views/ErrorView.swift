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
        isHidden = true
    }
    
    public func layout(_ display: Display<Any>) {
        switch display {
        case let .failure(_, retryAction): layoutError(retryAction)
        default: isHidden = true
        }
    }
    
    private func layoutError(_ retryAction: (() -> Void)?) {
        isHidden = false
        self.retryAction = retryAction
        render(
            .contentView(imageView),
            .button(exitButton),
            retryAction != nil ? .button(retryButton) : nil
        )
    }
    
    @objc private func retry() {
        retryAction?()
    }
    
    @objc private func exit() {
        delegate?.didPressExit()
    }
}
