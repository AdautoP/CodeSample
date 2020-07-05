//
//  CharacterDetailsViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import Foundation
import XCoordinator

class CharacterDetailsViewModel {
    private let router: WeakRouter<AppRoute>
    let character: Character
    
    init(router: WeakRouter<AppRoute>, character: Character) {
        self.router = router
        self.character = character
    }
}
