//
//  CharactersListViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import Foundation
import XCoordinator

class CharactersListViewModel {
    private let router: WeakRouter<AppRoute>
    
    init(router: WeakRouter<AppRoute>) {
        self.router = router
    }
}
