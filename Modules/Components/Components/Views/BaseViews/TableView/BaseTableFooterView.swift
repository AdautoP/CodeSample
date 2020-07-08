//
//  BaseTableFooterView.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

public class BaseTableFooterView: BaseView {
    private let activityIndicator = UIActivityIndicatorView(style: .medium) >> {
        $0.color = AppColors.Interface.orange
        $0.hidesWhenStopped = true
    }
    
    private let label = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .light)
        $0.textAlignment = .center
        $0.textColor = AppColors.Grays.black
        $0.text = "No more items to show."
        $0.isHidden = true
        $0.setCompressionResistance(.defaultHigh, for: .vertical)
    }
    
    public var state: State = .idle {
        didSet { resolveState(state) }
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(activityIndicator)
        addSubview(label)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        activityIndicator.centerInSuperview()
        
        label.edgesToSuperview()
    }
    
    public enum State {
        case loading
        case noMorePages
        case idle
    }
    
    private func resolveState(_ state: State) {
        switch state {
        case .idle:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            label.isHidden = true
            isHidden = true
            
        case .loading:
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            label.isHidden = true
            isHidden = false
            
        case .noMorePages:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            label.isHidden = false
            isHidden = false
        }
    }
}
