//
//  
//  CharactersListPresenter.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation

protocol CharactersListPresenting: AnyObject {
    var display: CharactersListDisplayable? { get }
    
    func presentCharactersListState(_ state: Display<CharactersListState>)
    func presentNextStep(_ action: CharactersListAction)
}

class CharactersListPresenter {
    weak var display: CharactersListDisplayable?
    let coordinator: CharactersListCoordinating
    
    init(coordinator: CharactersListCoordinating) {
        self.coordinator = coordinator
    }
}

extension CharactersListPresenter: CharactersListPresenting {
    func presentNextStep(_ action: CharactersListAction) {
        coordinator.perform(action)
    }
    
    func presentCharactersListState(_ state: Display<CharactersListState>) {
        display?.displayState(state)
    }
}
