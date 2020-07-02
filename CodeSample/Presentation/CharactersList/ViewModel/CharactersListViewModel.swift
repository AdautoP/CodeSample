//
//  CharactersListViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import Foundation
import RxSwift
import XCoordinator

class CharactersListViewModel {
    private let router: WeakRouter<AppRoute>
    private let service: RickyAndMortyService
    
    private var page = 0
    private var lastPage = 99999
    
    init(router: WeakRouter<AppRoute>, service: RickyAndMortyService = .init()) {
        self.router = router
        self.service = service
    }
    
    func getCharacters() -> Observable<State> {
        service
            .request(path: .allCharacters, withMethod: .get)
            .do(onNext: { self.lastPage = $0.info.pages })
            .map { .success($0.results) }
            .catchError(handleError)
    }
    
    func refreshCaracters() -> Observable<State> {
        if page < lastPage {
            return service
                .request(path: .allCharacters, withMethod: .get, page: page)
                .do(onNext: { _ in self.page += 1 })
                .map { .success($0.results) }
        } else {
            return .just(.noMorePages)
        }
        
    }
    
    private func handleError(_ error: Error) -> Observable<State> {
        if (error as? NetworkErrors) != nil {
            return .just(.specificError)
        }
        return .error(error)
    }
    
    enum State {
        case noMorePages
        case success([CharacterResponse])
        case specificError
    }
}
