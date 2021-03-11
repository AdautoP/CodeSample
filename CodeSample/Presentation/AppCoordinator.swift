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
            let viewModel = CharactersListViewModel(coordinator: self)
            let controller = CharactersListController(viewModel: viewModel)
            navigationController.pushViewController(controller, animated: true)
            
        case let .detail(character):
            let viewModel = CharacterDetailsViewModel(character: character)
            let controller = CharacterDetailsController(viewModel: viewModel)
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
