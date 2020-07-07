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
    private lazy var rootView = CharactersListRootView() >> { $0.delegate = self }
    
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
        getCharacters()
    }
    
    private func getCharacters() {
        viewModel
            .getCharacters()
            .displayable(retryAction: getCharacters)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}

extension CharactersListController {
    var state: Binder<Display<CharactersListViewModel.State>> {
        Binder(self) { controller, display in
            controller.layout(display)
            controller.rootView.layout(display)
        }
    }
}

extension CharactersListController: CharactersListRootViewDelegate {
    func didSelect(character: Character) {
        viewModel.selectCharacter(character)
    }
    
    func fetchMoreItems() {
        viewModel
            .getNewPage()
            .displayableWithoutLoading(retryAction: fetchMoreItems)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}
