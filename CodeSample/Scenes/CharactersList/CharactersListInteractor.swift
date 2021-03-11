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
    
    func loadCharacters(_ stored: Bool)
    func loadCharactersByName(name: String)
    func loadNewPage()
    func selectCharacter(_ character: Character)
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
    private func getCharacters() {
        loadCharacters()
    }
    
    func loadCharacters(_ stored: Bool = false) {
        service
            .requestAllCharacters(page: nil, name: nil)
            .do(onNext: { self.lastPage = $0.info.pages })
            .map { $0.results.map { Character($0) } }
            .do(onNext: { self.allCharacter = $0 })
            .map { CharactersListState.success($0) }
            .catch(handleError)
            .displayable(retryAction: getCharacters)
            .subscribe(onNext: { [weak self] in self?.presenter.presentCharactersListState($0) })
            .disposed(by: disposeBag)
    }
    
    func loadCharactersByName(name: String) {
        service
            .requestAllCharacters(page: nil, name: name)
            .map { $0.results.map { Character($0) } }
            .map { CharactersListState.success($0) }
            .catch(handleError)
            .displayable(retryAction: getCharacters)
            .subscribe(onNext: { [weak self] in self?.presenter.presentCharactersListState($0) })
            .disposed(by: disposeBag)
    }
    
    func loadNewPage() {
        if page <= lastPage {
            service
                .requestAllCharacters(page: page, name: nil)
                .map { $0.results.map { Character($0) } }
                .do(onNext: {
                    self.page += 1
                    self.allCharacter += $0
                })
                .map { _ in CharactersListState.success(self.allCharacter) }
                .catch(handleError)
                .displayableWithoutLoading(retryAction: loadNewPage)
                .subscribe(onNext: { [weak self] in self?.presenter.presentCharactersListState($0) })
                .disposed(by: disposeBag)
        } else {
            presenter.presentCharactersListState(.success(.noMorePages))
        }
    }
    
    /**
     # THIS FUNCTION IS MERELY FOR DEMONSTRATION
     
     - While we can map default errors from status code, maybe in some specific API one specific status code contains a
     body that carries a custom message to be displayed, with this function below we can handle those specif errors
     while still transmiting default errors.
     
     - Ex:
     
     ```swift
     private func handleError(_ error: Error) -> Observable<State> {
     if let networkError = (error as? NetworkErrors) {
     if case let .badRequest(code, body) = networkError, code == 404 {
     // DO SOMETHING ABOUT IT
     }
     }
     return .error(error)
     }
     ```
     **/
    
    private func handleError(_ error: Error) -> Observable<CharactersListState> {
        return .error(error)
    }
    
    func selectCharacter(_ character: Character) {
        presenter.presentNextStep(.showCharacter(character))
    }
}
