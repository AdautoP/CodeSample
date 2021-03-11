//
//  CharactersListViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import Foundation
import RxSwift

class CharactersListViewModel {
    private weak var coordinator: AppCoordinating?
    private let service: RickAndMortyProvider
    
    private var page = 2
    private var lastPage = 99_999
    
    private(set) var allCharacter = [Character]()
    
    init(
        coordinator: AppCoordinating,
        service: RickAndMortyProvider = RickyAndMortyService()
    ) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func getCharacters(_ stored: Bool = false) -> Observable<State> {
        service
            .requestAllCharacters(page: nil, name: nil)
            .do(onNext: { self.lastPage = $0.info.pages })
            .map { $0.results.map { Character($0) } }
            .do(onNext: { self.allCharacter = $0 })
            .map { .success($0) }
            .catch(handleError)
    }
    
    func getCharactersByName(name: String) -> Observable<State> {
        service
            .requestAllCharacters(page: nil, name: name)
            .map { $0.results.map { Character($0) } }
            .map { .success($0) }
            .catch(handleError)
    }
    
    func getNewPage() -> Observable<State> {
        if page <= lastPage {
            return service
                .requestAllCharacters(page: page, name: nil)
                .map { $0.results.map { Character($0) } }
                .do(onNext: {
                    self.page += 1
                    self.allCharacter += $0
                })
                .map { _ in .success(self.allCharacter) }
                .catch(handleError)
        } else {
            return .just(.noMorePages)
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
    
    private func handleError(_ error: Error) -> Observable<State> {
        return .error(error)
    }
    
    func selectCharacter(_ character: Character) {
        coordinator?.perform(.detail(character))
    }
    
    enum State {
        case noMorePages
        case success([Character])
        case customMessageError(String)
    }
}
