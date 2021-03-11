//
//  
//  CharacterDetailsFactory.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation

enum CharacterDetailsFactory {
    static func make(character: Character) -> CharacterDetailsViewController {
        let coordinator = CharacterDetailsCoordinator()
        let presenter = CharacterDetailsPresenter(coordinator: coordinator)
        let service = CharacterDetailsService()
        let interactor = CharacterDetailsInteractor(
            presenter: presenter,
            service: service,
            character: character
        )
        let controller = CharacterDetailsViewController(interactor: interactor)
        
        presenter.display = controller
        
        return controller
    }
}
