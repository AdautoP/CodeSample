//
//  
//  CharacterDetailsInteractor.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import Foundation
import RxSwift

protocol CharacterDetailsInteracting {
    func loadCharacters()
}

class CharacterDetailsInteractor {
    private let presenter: CharacterDetailsPresenting
    private let service: CharacterDetailsServicing
    private var character: Character
    private let disposeBag = DisposeBag()
    
    init(
        presenter: CharacterDetailsPresenting,
        service: CharacterDetailsServicing,
        character: Character
    ) {
        self.presenter = presenter
        self.service = service
        self.character = character
    }
}

extension CharacterDetailsInteractor: CharacterDetailsInteracting {
    func loadCharacters() {
        presenter.presentCharacter(.loading)
        service
            .requestMultipleEpisodes(character.episodesUrls) { result in
                switch result {
                case let .success(episodeResponses):
                    let episodes = episodeResponses.map { Episode($0) }
                    self.character.updating(episodes)
                    self.presenter.presentCharacter(.success(self.character))
                    
                case let .failure(error):
                    self.presenter.presentCharacter(.failure(error, self.loadCharacters))
                }
            }
    }
}
