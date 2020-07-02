//
//  CharacterListRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

class CharactersListRootView: BaseView {
    
    private lazy var tableView = UITableView() >> {
        $0.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifer)
        $0.backgroundColor = AppColors.Grays.lightGray
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(tableView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        tableView.edgesToSuperview()
    }
}
