//
//  BaseTableViewDelegateDataSource.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

@objc public protocol BaseTableViewDelegate: AnyObject {
    @objc optional func fetchMoreItems()
    @objc optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
}

public protocol BaseTableViewDataSource: AnyObject {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

extension BaseTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let scrollDidScroll = delegate?.scrollViewDidScroll?(scrollView) else {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if (lastYOffset > offsetY) && (lastYOffset < contentHeight - scrollView.frame.size.height) {
                footer.hideWarning()
            } else {
                if offsetY > (contentHeight - scrollView.frame.size.height) && canLoadMorePages {
                    canLoadMorePages = false
                    loadMorePages()
                    delegate?.fetchMoreItems?()
                }
            }
            lastYOffset = offsetY
            return
        }
        scrollDidScroll
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
}

extension BaseTableView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}
