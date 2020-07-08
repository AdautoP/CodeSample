//
//  BaseSearchController.swift
//  Components
//
//  Created by Adauto Pinheiro on 07/07/20.
//

import UIKit

public class BaseSearchController: UISearchController {
    public init() {
        super.init(nibName: nil, bundle: nil)
        obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = false
        searchBar.searchTextField.font = .appFont(size: 16, weight: .regular)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
