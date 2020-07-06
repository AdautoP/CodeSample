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
        
        navigationItem.largeTitleDisplayMode = .never
        
        rootView.layout(viewModel.character)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.layoutSubviews()
    }
}
