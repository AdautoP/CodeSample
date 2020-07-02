//
//  CharactersListController.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import Foundation

class CharactersListController: BaseController {
    private let viewModel: CharactersListViewModel
    private let rootView = CharactersListRootView()
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init()
        title = "Characters"
    }
    
    override func loadView() {
        view = rootView
    }
}
