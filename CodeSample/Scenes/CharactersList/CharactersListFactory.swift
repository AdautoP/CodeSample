//
//  
//  CharactersListFactory.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation

enum CharactersListFactory {
    static func make(coordinatorDelegate: CharactersListCoordinatingDelegate? = nil) -> CharactersListViewController {
        let coordinator = CharactersListCoordinator()
        let presenter = CharactersListPresenter(coordinator: coordinator)
        let service = CharactersListService()
        let interactor = CharactersListInteractor(presenter: presenter, service: service)
        let controller = CharactersListViewController(interactor: interactor)
        
        presenter.display = controller
        coordinator.delegate = coordinatorDelegate
        
        return controller
    }
}
