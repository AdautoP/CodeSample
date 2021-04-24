//
//  CharacterDetailsViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import Foundation
import RxSwift

protocol CharacterDetailsViewModelType: AnyObject {
    func getEpisodes() -> Observable<CharacterScreenData>
}

class CharacterDetailsViewModel: CharacterDetailsViewModelType {
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
    
    func getEpisodes() -> Observable<CharacterScreenData> {
        service
            .requestMultipleEpisodes(character.episodesUrls)
            .map { $0.map { Episode($0) } }
            .map { self.character.updating($0) }
            .map(mapper.mapRows)
    }
}
