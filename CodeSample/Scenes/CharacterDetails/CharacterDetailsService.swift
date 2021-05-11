//
//  
//  CharacterDetailsService.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import UIKit

protocol CharacterDetailsServicing {
    func requestMultipleEpisodes(_ episodeUrls: [String], _ completion: @escaping (Result<[EpisodeResponse], NetworkError>) -> Void)
}

class CharacterDetailsService {
    private let baseUrlPath = "https://rickandmortyapi.com/api"
    
    private var urlComponents = URLComponents() >> {
        $0.scheme = "https"
        $0.host = "rickandmortyapi.com"
    }
}

extension CharacterDetailsService: CharacterDetailsServicing {
    func requestMultipleEpisodes(_ episodeUrls: [String], _ completion: @escaping (Result<[EpisodeResponse], NetworkError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var episodes = [EpisodeResponse]()
        var networkError: NetworkError?
        episodeUrls.forEach {
            dispatchGroup.enter()
            URLSessionManager.request(
                type: EpisodeResponse.self,
                path: $0,
                withMethod: .get
            ) { result in
                switch result {
                case let .success(episode):
                    episodes.append(episode)

                case let .failure(error):
                    networkError = .commonError(error)
                }

                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            if !episodes.isEmpty {
                completion(.success(episodes))
            } else if let networkError = networkError {
                completion(.failure(networkError))
            }
        }
    }
}
