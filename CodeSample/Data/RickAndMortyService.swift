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
    
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    func request<T: Decodable>(path: RickAndMortyEndpoints, withMethod method: RequestMethod, body: [String: Any]? = nil) -> Observable<T> {
        URLManager.request(path: baseUrl + path.rawValue, withMethod: method, body: body)
        
    }
}

enum RickAndMortyEndpoints: String {
    case allCharacters = "/character"
}
