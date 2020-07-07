//
//  CharacterDetailsMapper.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import Foundation

class CharacterDetailsMapper {
    func mapRows(_ character: Character) -> CharacterDetailsViewModel.ScreenData {
        let rows: [DetailRowType] = [
            .header(character.image),
            .name(character.name),
            .status(character.status),
            .vText(title: "Species", value: character.species),
            .vText(title: "Gender", value: character.gender.rawValue),
            .vText(title: "Origin", value: character.origin.name),
            .vText(title: "Last Location", value: character.lastLocation.name)
        ]
        
        return .init(rows: rows, episodes: character.episodes)
    }
}
