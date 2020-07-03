//
//  BaseTableViewCell.swift
//  Components
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AppColors.Grays.lightGray
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
