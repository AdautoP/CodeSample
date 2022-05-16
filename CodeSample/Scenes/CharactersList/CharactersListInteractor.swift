//
//  
//  CharactersListInteractor.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation
import RxSwift

protocol CharactersListInteracting {
    var allCharacter: [Character] { get set }
    
    func loadCharacters(_ stored: Bool, _ fallBack: @escaping () -> Void)
    func loadCharactersByName(name: String, _ fallBack: @escaping () -> Void)
    func loadNewPage(_ fallBack: @escaping () -> Void)
    func selectCharacter(_ character: Character)
    func cancelSearch()
}

class CharactersListInteractor {
    private let presenter: CharactersListPresenting
    private let service: CharactersListServicing
    private let disposeBag = DisposeBag()
    
    private var page = 2
    private var lastPage = 99_999
    
    var allCharacter = [Character]()
    
    init(presenter: CharactersListPresenting, service: CharactersListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension CharactersListInteractor: CharactersListInteracting {
    func cancelSearch() {
        presenter.presentCharactersListState(.success(.success(allCharacter)))
    }

    func selectCharacter(_ character: Character) {
        presenter.presentNextStep(.showCharacter(character))
    }

    private func getCharacters() {
        loadCharacters()
    }
    
    func loadCharacters(_ stored: Bool = false, _ fallBack: @escaping () -> Void = {}) {
        presenter.presentCharactersListState(.loading)
        service
            .requestAllCharacters(page: nil, name: nil) { result in
                switch result {
                case let .success(charactersList):
                    self.lastPage = charactersList.info.pages
                    let characters = charactersList.results.map { Character($0) }
                    self.allCharacter = characters
                    self.presenter.presentCharactersListState(.success(.success(characters)))

                case let .failure(error):
                    self.presenter.presentCharactersListState(.failure(error, fallBack))
                }
            }
    }
    
    func loadCharactersByName(name: String, _ fallBack: @escaping () -> Void = {}) {
        presenter.presentCharactersListState(.loading)
        service
            .requestAllCharacters(page: nil, name: name) { result in
                switch result {
                case let .success(charactersList):
                    self.lastPage = charactersList.info.pages
                    let characters = charactersList.results.map { Character($0) }
                    self.presenter.presentCharactersListState(.success(.success(characters)))

                case let .failure(error):
                    self.presenter.presentCharactersListState(.failure(error, fallBack))
                }
            }
    }

    func loadNewPage(_ fallBack: @escaping () -> Void) {
        if page <= lastPage {
            service
                .requestAllCharacters(page: page, name: nil) { result in
                    switch result {
                    case let .success(charactersList):
                        self.page += 1
                        self.lastPage = charactersList.info.pages
                        let characters = charactersList.results.map { Character($0) }
                        self.allCharacter += characters
                        self.presenter.presentCharactersListState(.success(.success(self.allCharacter)))

                    case let .failure(error):
                        self.presenter.presentCharactersListState(.failure(error, fallBack))
                    }
                }
        } else {
            presenter.presentCharactersListState(.success(.noMorePages))
        }
    }
}
