//
//  BaseTableViewCell.swift
//  Components
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.identifer)
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
