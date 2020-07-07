//
//  CharactersListController.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import RxCocoa
import RxSwift
import UIKit

class CharactersListController: BaseController {
    private let disposeBag = DisposeBag()
    
    private lazy var searchController = UISearchController() >> {
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.showsCancelButton = false
        $0.searchBar.delegate = self
    }
    
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
        
        navigationItem.searchController = searchController
        searchController
            .searchBar
            .rx
            .text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { self.getCharacterByName($0) })
            .disposed(by: disposeBag)
    }
    
    private func getCharacters() {
        viewModel
            .getCharacters()
            .displayable(retryAction: getCharacters)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
    
    private func getCharacterByName(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        self.viewModel
            .getCharactersByName(name: text)
            .displayable(retryAction: nil)
            .bind(to: self.state)
            .disposed(by: self.disposeBag)
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

extension CharactersListController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Observable
            .just(.success(viewModel.allCharacter))
            .displayable(retryAction: nil)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}
