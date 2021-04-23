//
//  CharacterDetailsViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import Foundation
import RxSwift

class CharacterDetailsViewModel {
    private var character: Character
    private let mapper = CharacterDetailsMapper()
    private let service: RickAndMortyProvider
    
    init(
        character: Character,
        service: RickAndMortyProvider = RickyAndMortyService()
    ) {
        self.character = character
        self.service = service
    }
    
    func getEpisodes() -> Observable<ScreenData> {
        service
            .requestMultipleEpisodes(character.episodesUrls)
            .map { $0.map { Episode($0) } }
            .map { self.character.updating($0) }
            .map(mapper.mapRows)
    }
    
    struct ScreenData {
        var rows: [DetailRowType]
        var episodes: [Episode]
    }
}