//
//  BaseTableView.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

open class BaseTableView: UITableView {
    
    public init() {
        super.init(frame: .zero, style: .grouped)
        
    }
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
