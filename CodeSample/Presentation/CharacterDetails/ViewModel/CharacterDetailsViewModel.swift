//
//  CharacterDetailsViewModel.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import Foundation
import RxSwift
import XCoordinator

class CharacterDetailsViewModel {
    private let router: WeakRouter<AppRoute>
    private var character: Character
    private let mapper = CharacterDetailsMapper()
    private let service: RickyAndMortyService
    
    init(router: WeakRouter<AppRoute>, character: Character, service: RickyAndMortyService = .init()) {
        self.router = router
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
