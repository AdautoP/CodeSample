//
//  AppCoordinator.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import Components
import UIKit
import XCoordinator

enum AppRoute: Route {
    case start
    case detail(Character)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(rootViewController: BaseNavigationController(), initialRoute: .start)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .start:
            let viewModel = CharactersListViewModel(router: weakRouter)
            let controller = CharactersListController(viewModel: viewModel)
            return .push(controller)
            
        case let .detail(character):
            let viewModel = CharacterDetailsViewModel(router: weakRouter, character: character)
            let controller = CharacterDetailsController(viewModel: viewModel)
            return .push(controller)
        }
    }
}
