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
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(rootViewController: BaseNavigationController(), initialRoute: .start)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .start: return .push(BaseController())
        }
    }
}
