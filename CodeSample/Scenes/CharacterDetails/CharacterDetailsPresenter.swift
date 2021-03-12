//
//  
//  CharacterDetailsPresenter.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation

protocol CharacterDetailsPresenting: AnyObject {
    var display: CharacterDetailsDisplayable? { get }
    
    func presentCharacter(_ character: Display<Character>)
    func presentNextStep(_ action: CharacterDetailsAction)
}

class CharacterDetailsPresenter {
    weak var display: CharacterDetailsDisplayable?
    private let coordinator: CharacterDetailsCoordinating
    
    init(coordinator: CharacterDetailsCoordinating) {
        self.coordinator = coordinator
    }
    
    private func mapRows(_ character: Display<Character>) -> Display<CharacterScreenData> {
        guard let value = character.value else {
            return character.map(newValue: .init(rows: [], episodes: []))
        }
        
        let rows: [DetailRowType] = [
            .header(value.image),
            .name(value.name),
            .status(value.status),
            .vText(title: L10n.Details.species, value: value.species),
            .vText(title: L10n.Details.gender, value: value.gender.rawValue),
            .vText(title: L10n.Details.origin, value: value.origin.name),
            .vText(title: L10n.Details.lastLocation, value: value.lastLocation.name)
        ]
        
        return .success(.init(rows: rows, episodes: value.episodes))
    }
}

extension CharacterDetailsPresenter: CharacterDetailsPresenting {
    func presentCharacter(_ character: Display<Character>) {
        display?.displayCharacterScreenData(mapRows(character))
    }
    
    func presentNextStep(_ action: CharacterDetailsAction) {
        coordinator.perform(action)
    }
}
