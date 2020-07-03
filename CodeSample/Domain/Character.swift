//
//  Character.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

struct Character {
    var id: Int
    var name: String
    var status: Status
    var species: String
    var gender: String
    var image: String
    var lastLocation: String
    
    enum Status {
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
        gender = response.gender
        image = response.image
        lastLocation = response.location.name
    }
}
