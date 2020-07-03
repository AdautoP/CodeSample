//
//  BaseTableFooterView.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

public class BaseTableFooterView: BaseView {
    private let activityIndicator = UIActivityIndicatorView(style: .medium) >> {
        $0.color = AppColors.Interface.yellow
        $0.hidesWhenStopped = true
    }
    
    private let label = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .light)
        $0.textColor = AppColors.Grays.black
        $0.text = "No more items to show."
        $0.isHidden = true
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(activityIndicator)
        addSubview(label)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        activityIndicator.centerInSuperview()
        activityIndicator.verticalToSuperview(insets: .vertical(8))
        
        label.centerInSuperview()
        label.verticalToSuperview(insets: .vertical(8))
    }
    
    public func startAnimating() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    public func stopAnimating() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
    
    public func noMorePages() {
        label.isHidden = false
        isHidden = false
    }
}
