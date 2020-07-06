//
//  Episode.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import Foundation

struct Episode {
    var name: String
    var airDate: String
    var seasonName: String
    var characters: [Character] = []
    var charactersUrls: [String]
}

extension Episode {
    init(_ response: EpisodeResponse) {
        name = response.name
        airDate = response.airDate
        seasonName = response.episode
        charactersUrls = response.characters
    }
}
