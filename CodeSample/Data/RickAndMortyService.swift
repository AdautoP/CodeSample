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
    
    func request(path: RickAndMortyEndpoints, withMethod method: RequestMethod, page: Int? = nil) -> Observable<CharactersListResponse> {
        urlComponents.path = path.rawValue
        if let page = page {
            urlComponents.queryItems = [URLQueryItem(name: "page", value: String(page))]
        }
        
        return URLManager.request(path: urlComponents.url?.absoluteString ?? "", withMethod: method, body: nil)
    }
}

enum RickAndMortyEndpoints: String {
    case allCharacters = "/api/character"
}
