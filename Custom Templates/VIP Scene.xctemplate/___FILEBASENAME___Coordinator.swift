//
//  ___FILEHEADER___
//

import Foundation

enum ___VARIABLE_productName:identifier___Action {
    case confirm
}

protocol ___VARIABLE_productName:identifier___Coordinating {
    func perform(_ action: ___VARIABLE_productName:identifier___Action)
}

class ___VARIABLE_productName:identifier___Coordinator {}

extension ___VARIABLE_productName:identifier___Coordinator: ___VARIABLE_productName:identifier___Coordinating {
    func perform(_ action: ___VARIABLE_productName:identifier___Action) {
        // da um push numa navigation ou qualquer merda
    }
}
