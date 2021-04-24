//
//  
//  CharactersListService.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import RxSwift
import UIKit

protocol CharactersListServicing {
    func requestAllCharacters(page: Int?, name: String?, _ completion: @escaping (Result<CharactersListResponse, NetworkError>) -> Void)
}

class CharactersListService {
    private let baseUrlPath = "https://rickandmortyapi.com/api"
    
    private var urlComponents = URLComponents() >> {
        $0.scheme = "https"
        $0.host = "rickandmortyapi.com"
    }
}

extension CharactersListService: CharactersListServicing {
    func requestAllCharacters(page: Int? = nil, name: String? = nil, _ completion: @escaping (Result<CharactersListResponse, NetworkError>) -> Void) {
        urlComponents.path = RickAndMortyEndpoints.allCharacters.rawValue
        urlComponents.queryItems = []
        if let page = page {
            urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        if let name = name {
            urlComponents.queryItems?.append(URLQueryItem(name: "name", value: name))
        }

        URLSessionManager.request(
            type: CharactersListResponse.self,
            path: urlComponents.url?.absoluteString ?? "",
            withMethod: .get,
            body: nil
        ) { result in DispatchQueue.main.async { completion(result)}  }
    }
}
