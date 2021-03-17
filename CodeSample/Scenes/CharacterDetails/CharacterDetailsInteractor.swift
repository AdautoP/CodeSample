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
        service
            .requestMultipleEpisodes(character.episodesUrls)
            .map { episodes in
                episodes.map { Episode($0) }
            }
            .map { episodes in
                self.character.updating(episodes)
            }
            .displayable(retryAction: loadCharacters)
            .subscribe(onNext: { [weak self] in self?.presenter.presentCharacter($0) })
            .disposed(by: disposeBag)
    }
}
