//
//  CharacterResponse.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import Foundation

struct CharactersListResponse: Decodable {
    var info: Info
    var results: [CharacterResponse]
    
    struct Info: Decodable {
        var count: Int
        var pages: Int
    }
}

struct CharacterResponse: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var image: String
}
