//
//  
//  CharactersListViewController.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import RxCocoa
import RxSwift
import UIKit

enum CharactersListState {
    case noMorePages
    case success([Character])
    case customMessageError(String)
}

protocol CharactersListDisplayable: AnyObject {
    func displayState(_ state: Display<CharactersListState>)
}

class CharactersListViewController: BaseController<CharactersListInteracting, CharactersListRootView> {
    private let disposeBag = DisposeBag()
    
    private lazy var searchController = BaseSearchController() >> {
        $0.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        navigationItem.searchController = searchController
        rootView.delegate = self
        interactor.loadCharacters(false)
        
        searchController
            .searchBar
            .searchTextField
            .rx
            .controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                if let text = self?.searchController.searchBar.text, !text.isEmpty {
                    self?.interactor.loadCharactersByName(name: text)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CharactersListViewController: CharactersListDisplayable {
    func displayState(_ state: Display<CharactersListState>) {
        layout(state)
        rootView.layout(state)
    }
}

extension CharactersListViewController: CharactersListRootViewDelegate {
    func fetchMoreItems() {
        interactor.loadNewPage()
    }
    
    func didSelect(character: Character) {
        interactor.selectCharacter(character)
    }
}

extension CharactersListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else { return }
        displayState(.success(.success(interactor.allCharacter)))
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        displayState(.success(.success(interactor.allCharacter)))
    }
}
