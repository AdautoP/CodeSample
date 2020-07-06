//
//  AloeStackView+Ext.swift
//  Components
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import AloeStackView
import UIKit

public extension AloeStackView {
    func addRow(_ row: UIView, inset: UIEdgeInsets) {
        self.addRow(row)
        self.setInset(forRow: row, inset: inset)
    }
}
