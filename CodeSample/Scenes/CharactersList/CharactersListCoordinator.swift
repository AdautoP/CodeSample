//
//  
//  CharactersListCoordinator.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation

enum CharactersListAction {
    case showCharacter(Character)
}

protocol CharactersListCoordinatingDelegate: AnyObject {
    func showCharacter(_ character: Character)
}

protocol CharactersListCoordinating {
    var delegate: CharactersListCoordinatingDelegate? { get set }
    
    func perform(_ action: CharactersListAction)
}

class CharactersListCoordinator {
    weak var delegate: CharactersListCoordinatingDelegate?
}

extension CharactersListCoordinator: CharactersListCoordinating {
    func perform(_ action: CharactersListAction) {
        if case let .showCharacter(character) = action {
            delegate?.showCharacter(character)
        }
    }
}
