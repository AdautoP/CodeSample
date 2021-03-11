//
//  
//  CharacterDetailsService.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import RxSwift
import UIKit

protocol CharacterDetailsServicing {
    func requestMultipleEpisodes(_ episodeUrls: [String]) -> Observable<[EpisodeResponse]>
}

class CharacterDetailsService {
    private let baseUrlPath = "https://rickandmortyapi.com/api"
    
    private var urlComponents = URLComponents() >> {
        $0.scheme = "https"
        $0.host = "rickandmortyapi.com"
    }
    
    private func requestEpisode( _ episodeUrl: String) -> Observable<EpisodeResponse> {
        URLManager.request(path: episodeUrl, withMethod: .get)
    }

    private func accumulate(
        accumulatedEpisodes: AccumulatedEpisodes,
        episode: EpisodeResponse
    ) throws -> AccumulatedEpisodes {
        accumulatedEpisodes.episodes.append(episode)
        return accumulatedEpisodes
    }
}

extension CharacterDetailsService: CharacterDetailsServicing {
    func requestMultipleEpisodes(_ episodeUrls: [String]) -> Observable<[EpisodeResponse]> {
        Observable
            .from(episodeUrls)
            .concatMap(requestEpisode)
            .reduce(AccumulatedEpisodes(), accumulator: accumulate)
            .map { $0.episodes }
    }
}
