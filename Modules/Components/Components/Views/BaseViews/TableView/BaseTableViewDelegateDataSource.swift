//
//  BaseTableViewDelegateDataSource.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

public protocol BaseTableViewDelegateDataSource: AnyObject {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func fetchMoreItems()
}

extension BaseTableView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        delegate?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > (contentHeight - scrollView.frame.size.height) && canLoadMorePages {
            canLoadMorePages = false
            delegate?.fetchMoreItems()
        }
    }
}
