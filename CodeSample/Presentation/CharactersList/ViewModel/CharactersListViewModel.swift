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
    
    private var page = 2
    private var lastPage = 99_999
    
    init(router: WeakRouter<AppRoute>, service: RickyAndMortyService = .init()) {
        self.router = router
        self.service = service
    }
    
    func getCharacters() -> Observable<State> {
        service
            .request(path: .allCharacters, withMethod: .get)
            .do(onNext: { self.lastPage = $0.info.pages })
            .map { .success($0.results.map { Character($0) }) }
            .catchError(handleError)
    }
    
    func getNewPage() -> Observable<State> {
        if page <= 3 {
            return service
                .request(path: .allCharacters, withMethod: .get, page: page)
                .do(onNext: { _ in self.page += 1 })
                .map { .success($0.results.map { Character($0) }) }
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
        case success([Character])
        case specificError
    }
}
