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
    private init() {}
    
    static let shared = RickyAndMortyService()
    
    private var urlComponents = URLComponents(string: "https://rickandmortyapi.com/api")
    
    func request<T: Decodable>(path: RickAndMortyEndpoints, withMethod method: RequestMethod, page: Int? = nil) -> Observable<T> {
        if let page = page {
            urlComponents?.queryItems = [URLQueryItem(name: "page", value: String(page))]
        }
        
        urlComponents?.path = path.rawValue
        
        return URLManager.request(path: urlComponents?.url?.absoluteString ?? "", withMethod: method, body: nil)
    }
}

enum RickAndMortyEndpoints: String {
    case allCharacters = "/character"
}
