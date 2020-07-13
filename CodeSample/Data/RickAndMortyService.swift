//
//  RickyAndMortyService.swift
//  Core
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import Core
import Foundation
import RxSwift

class RickyAndMortyService {
    
    private let baseUrlPath = "https://rickandmortyapi.com/api"
    
    private var urlComponents = URLComponents() >> {
        $0.scheme = "https"
        $0.host = "rickandmortyapi.com"
    }
    
    func requestAllCharacters(page: Int? = nil, name: String? = nil) -> Observable<CharactersListResponse> {
        urlComponents.path = RickAndMortyEndpoints.allCharacters.rawValue
        urlComponents.queryItems = []
        if let page = page {
            urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        if let name = name {
            urlComponents.queryItems?.append(URLQueryItem(name: "name", value: name))
        }
        
        return URLManager.request(path: urlComponents.url?.absoluteString ?? "", withMethod: .get, body: nil)
    }
    
    func requestMultipleEpisodes(_ episodeUrls: [String]) -> Observable<[EpisodeResponse]> {
        Observable
            .from(episodeUrls)
            .concatMap(requestEpisode)
            .reduce(AccumulatedEpisodes(), accumulator: accumulate)
            .map { $0.episodes }
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

enum RickAndMortyEndpoints: String {
    case allCharacters = "/api/character"
    case episodes = "/api/episode"
}
