//
//  
//  CharacterDetailsCoordinator.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation

enum CharacterDetailsAction {
    case confirm
}

protocol CharacterDetailsCoordinating {
    func perform(_ action: CharacterDetailsAction)
}

class CharacterDetailsCoordinator {}

extension CharacterDetailsCoordinator: CharacterDetailsCoordinating {
    func perform(_ action: CharacterDetailsAction) {
        // da um push numa navigation ou qualquer merda
    }
}
