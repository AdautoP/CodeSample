//
//  CharactersListController.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import Foundation
import RxCocoa
import RxSwift

class CharactersListController: BaseController {
    private let disposeBag = DisposeBag()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel
            .getCharacters()
            .displayable(retryAction: nil)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}

extension CharactersListController {
    var state: Binder<Display<CharactersListViewModel.State>> {
        Binder(self) { controller, display in
            controller.layout(display)
        }
    }
}
