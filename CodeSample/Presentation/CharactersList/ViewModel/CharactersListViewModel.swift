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
        if page <= lastPage {
            return service
                .request(path: .allCharacters, withMethod: .get, page: page)
                .do(onNext: { _ in self.page += 1 })
                .map { .success($0.results.map { Character($0) }) }
        } else {
            return .just(.noMorePages)
        }
    }
    
    /**
    # THIS FUNCTION IS MERELY FOR DEMONSTRATION
        
    - While we can map default errors from status code, maybe in some specific API one specific status code contains a body that carries a custom message to be displayed, with this function below we can handle those specif errors while still transmiting default errors.
     
    - Ex:
    
    ```swift
    private func handleError(_ error: Error) -> Observable<State> {
        if let customError = error as? NetworkErrors {
            if case let .badRequest(_, body) = customError {
                if let message = body["message"] as? String {
                    return .just(.customMessageError(message))
                }
            }
            return .error(error)
        }
        return .error(error)
    }
    ```
    **/
    
    private func handleError(_ error: Error) -> Observable<State> {
        if (error as? NetworkErrors) != nil {
            return .error(error)
        }
        return .error(error)
    }
    
    enum State {
        case noMorePages
        case success([Character])
        case customMessageError(String)
    }
}
