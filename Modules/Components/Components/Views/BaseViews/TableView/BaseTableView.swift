//
//  BaseTableView.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

open class BaseTableView: UITableView {
    
    public let footer = BaseTableFooterView()
    
    public var canLoadMorePages = true
    
    public init() {
        super.init(frame: .zero, style: .grouped)
        self.tableFooterView = footer
    }
    
    override open func reloadData() {
        super.reloadData()
        footer.stopAnimating()
        canLoadMorePages = true
    }
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadMorePages() {
        footer.isHidden = false
        footer.startAnimating()
        layoutSubviews()
        canLoadMorePages = false
    }
    
    public func noMorePages() {
        footer.isHidden = false
        footer.stopAnimating()
        footer.noMorePages()
        canLoadMorePages = false
    }
}
