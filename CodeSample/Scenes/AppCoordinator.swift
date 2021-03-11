//
//  AppCoordinator.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import Components
import UIKit

enum AppAction {
    case start
    case detail(Character)
}

protocol AppCoordinating: AnyObject {
    func perform(_ action: AppAction)
}

class AppCoordinator: AppCoordinating {
    let navigationController = BaseNavigationController()
    
    func perform(_ action: AppAction) {
        switch action {
        case .start:
            let controller = CharactersListFactory.make(coordinatorDelegate: self)
            navigationController.pushViewController(controller, animated: true)
            
        case let .detail(character):
            let controller = CharacterDetailsFactory.make(character: character)
            navigationController.pushViewController(controller, animated: true)
        }
    }
}

extension AppCoordinator: CharactersListCoordinatingDelegate {
    func showCharacter(_ character: Character) {
        perform(.detail(character))
    }
}
