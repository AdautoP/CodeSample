//
//  LoadingView.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

public class LoadingView: BaseView {
    let activityIndicatorView = UIActivityIndicatorView() >> {
        $0.hidesWhenStopped = true
        $0.style = .large
        $0.color = AppColors.Interface.yellow
    }
    
    override init() {
        super.init()
        alpha = 0
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(activityIndicatorView)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        activityIndicatorView.centerInSuperview()
    }
    
    public func layout<T>(_ display: Display<T>) {
        switch display {
        case .loading: animateIn()
        default: animateOut()
        }
    }
    
    private func animateIn() {
        UIView.animate(
        withDuration: 0.2,
        animations: { self.alpha = 1 },
        completion: { _ in self.activityIndicatorView.startAnimating() }
        )
        
    }
    
    private func animateOut() {
        activityIndicatorView.stopAnimating()
        UIView.animate(
            withDuration: 0.2,
            animations: { self.alpha = 0 }
        )
    }
}
