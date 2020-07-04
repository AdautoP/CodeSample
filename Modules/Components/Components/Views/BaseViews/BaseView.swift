//
//  BaseView.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

open class BaseView: UIView {
    public init() {
        super.init(frame: .zero)
        backgroundColor = AppColors.Grays.lightGray
        buildSubviews()
        buildConstraints()
        buildAditionalConfiguration()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        buildSubviews()
        buildConstraints()
        buildAditionalConfiguration()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func buildSubviews() {}
    open func buildConstraints() {}
    open func buildAditionalConfiguration() {}
    
}
