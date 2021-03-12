//
//  Character.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

struct Character: Equatable {
    var id: Int
    var name: String
    var status: Status
    var species: String
    var image: String
    var lastLocation: CharacterResponse.Location
    var origin: CharacterResponse.Location
    var gender: Gender
    var episodes: [Episode] = []
    var episodesUrls: [String]
    
    enum Gender: String {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown = "Unknown"
        
        init(_ gender: String) {
            switch gender {
            case "Male": self = .male
            case "Female": self = .female
            case "Genderless": self = .genderless
            default: self = .unknown
            }
        }
    }
    
    enum Status: StatusRepresentable, Equatable {
        case alive
        case dead
        case unknown
        
        init(_ status: String) {
            switch status {
            case "Alive": self = .alive
            case "Dead": self = .dead
            default: self = .unknown
            }
        }
        
        var color: UIColor {
            switch self {
            case .alive: return AppColors.Interface.green
            case .dead: return AppColors.Interface.red
            case .unknown: return AppColors.Grays.darkGray
            }
        }
        
        var text: String {
            switch self {
            case .alive: return "Alive"
            case .dead: return "Dead"
            case .unknown: return "Unknown"
            }
        }
    }
}

extension Character {
    init(_ response: CharacterResponse) {
        id = response.id
        name = response.name
        status = Status(response.status)
        species = response.species
        gender = Gender(response.gender)
        image = response.image
        lastLocation = response.location
        origin = response.origin
        episodesUrls = response.episode
    }
    
    @discardableResult
    mutating func updating(_ episodes: [Episode]) -> Character {
        self.episodes = episodes
        return self
    }
}
