//
//  EpisodeResponse.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import Foundation

struct EpisodeResponse: Decodable {
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
}
