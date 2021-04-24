//
//  CharacterDetailsMapper.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import Foundation

class CharacterDetailsMapper {
    func mapRows(_ character: Character) -> CharacterScreenData {
        let rows: [DetailRowType] = [
            .header(character.image),
            .name(character.name),
            .status(character.status),
            .vText(title: L10n.Details.species, value: character.species),
            .vText(title: L10n.Details.gender, value: character.gender.rawValue),
            .vText(title: L10n.Details.origin, value: character.origin.name),
            .vText(title: L10n.Details.lastLocation, value: character.lastLocation.name)
        ]
        
        return .init(rows: rows, episodes: character.episodes)
    }
}
