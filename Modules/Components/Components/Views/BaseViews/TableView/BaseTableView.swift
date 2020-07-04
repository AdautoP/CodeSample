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
    
    private lazy var tableView = UITableView() >> {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = backgroundColor
    }
    
    public let footer = BaseTableFooterView()
    
    private let stackView = UIStackView() >> {
        $0.spacing = 0
        $0.distribution = .fill
        $0.axis = .vertical
        $0.backgroundColor = AppColors.Grays.lightGray
    }
    
    public var separatorStyle: UITableViewCell.SeparatorStyle {
        get { tableView.separatorStyle }
        set { tableView.separatorStyle = newValue }
    }
    
    public var contentInset: UIEdgeInsets {
        get { tableView.contentInset }
        set { tableView.contentInset = newValue }
    }
    
    public var canLoadMorePages = true
    public var lastYOffset: CGFloat = 0
    
    override open func buildSubviews() {
        super.buildSubviews()
        addSubview(stackView)
        
        stackView.addArrangedSubview(tableView)
    }
    
    override open func buildConstraints() {
        super.buildConstraints()
        stackView.edgesToSuperview(usingSafeArea: true)
    }
    
    public func register(_ cellClass: AnyClass?, forCellReuseIdentifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    public func reloadData() {
        tableView.reloadData()
        canLoadMorePages = true
        stackView.removeArrangedSubview(footer)
    }
    
    public func loadMorePages() {
        stackView.addArrangedSubview(footer)
        footer.startAnimating()
        canLoadMorePages = false
    }
    
    public func noMorePages() {
        stackView.addArrangedSubview(footer)
        footer.stopAnimating()
        footer.noMorePages()
        lastYOffset = 0
        canLoadMorePages = true
    }
}
