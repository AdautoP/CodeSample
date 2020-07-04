//
//  BaseTableViewDelegateDataSource.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

public protocol BaseTableViewDelegate: AnyObject {
    func fetchMoreItems()
}

public protocol BaseTableViewDataSource: AnyObject {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

extension BaseTableView: UITableViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (lastYOffset > offsetY) && (lastYOffset < contentHeight - scrollView.frame.size.height) {
            print("lastY: \(lastYOffset) / currentY: \(offsetY)" )
            footer.hideWarning()
        } else {
            if offsetY > (contentHeight - scrollView.frame.size.height) && canLoadMorePages {
                canLoadMorePages = false
                loadMorePages()
                delegate?.fetchMoreItems()
            }
        }
        lastYOffset = offsetY
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
