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
    func requestAllCharacters(page: Int?, name: String?) -> Observable<CharactersListResponse>
}

class CharactersListService {
    private let baseUrlPath = "https://rickandmortyapi.com/api"
    
    private var urlComponents = URLComponents() >> {
        $0.scheme = "https"
        $0.host = "rickandmortyapi.com"
    }
}

extension CharactersListService: CharactersListServicing {
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
}
