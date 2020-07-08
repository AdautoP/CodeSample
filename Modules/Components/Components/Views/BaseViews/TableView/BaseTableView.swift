//
//  BaseTableView.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

open class BaseTableView: BaseView {
    
    public weak var delegate: BaseTableViewDelegate?
    public weak var dataSource: BaseTableViewDataSource?
    
    public var nomeMorePages = false
    
    private lazy var tableView = UITableView() >> {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = backgroundColor
        $0.separatorStyle = .none
    }
    
    public let footer = BaseTableFooterView()
    
    public var separatorStyle: UITableViewCell.SeparatorStyle {
        get { tableView.separatorStyle }
        set { tableView.separatorStyle = newValue }
    }
    
    public var contentInset: UIEdgeInsets {
        get { tableView.contentInset }
        set { tableView.contentInset = newValue }
    }
    
    public var hasVisibleCells: Bool { !tableView.visibleCells.isEmpty }
    
    public var canLoadMorePages = true
    public var lastYOffset: CGFloat = 0
    
    override open func buildSubviews() {
        super.buildSubviews()
        addSubview(tableView)
        tableView.tableFooterView = footer
        
        footer.frame = CGRect(
            x: 0,
            y: tableView.bounds.maxY,
            width: tableView.bounds.width,
            height: 24
        )
    }
    
    override open func buildConstraints() {
        super.buildConstraints()
        tableView.edgesToSuperview(usingSafeArea: true)
    }
    
    public func register(_ cellClass: AnyClass?, forCellReuseIdentifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    public func reloadData() {
        tableView.reloadData()
        canLoadMorePages = true
        footer.state = .idle
    }
}
