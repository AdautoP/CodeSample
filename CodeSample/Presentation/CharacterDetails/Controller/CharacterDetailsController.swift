//
//  CharacterDetailsController.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import Foundation

class CharacterDetailsController: BaseController {
    private let viewModel: CharacterDetailsViewModel
    private let rootView = CharacterDetailsRootView()
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.character.name
        
        rootView.layout(viewModel.character)
    }
}
