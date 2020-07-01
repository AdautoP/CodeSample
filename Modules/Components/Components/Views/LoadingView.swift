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
        $0.style = .medium
    }
    
    override init() {
        super.init()
        isHidden = true
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
    
    public func layout(_ display: Display<Any>) {
        switch display {
        case .loading: animateIn()
        default: animateOut()
        }
    }
    
    func animateIn() {
        isHidden = false
        UIView.animate(
        withDuration: 0.2,
        animations: { self.alpha = 1 },
        completion: { _ in self.activityIndicatorView.startAnimating() }
        )
        
    }
    
    func animateOut() {
        activityIndicatorView.stopAnimating()
        UIView.animate(
            withDuration: 0.2,
            animations: { self.alpha = 0 },
            completion: { _ in self.isHidden = true }
            )
    }
}
