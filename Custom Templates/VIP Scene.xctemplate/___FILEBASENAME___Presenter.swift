//
//  ___FILEHEADER___
//

import Foundation

protocol ___VARIABLE_productName:identifier___Presenting: AnyObject {
    var display: ___VARIABLE_productName:identifier___Displayable? { get }
    
    func presentSomething()
    func presentNextStep(_ action: ___VARIABLE_productName:identifier___Action)
}

class ___VARIABLE_productName:identifier___Presenter {
    weak var display: ___VARIABLE_productName:identifier___Displayable?
    let coordinator: ___VARIABLE_productName:identifier___Coordinating
    
    init(coordinator: ___VARIABLE_productName:identifier___Coordinating) {
        self.coordinator = coordinator
    }
}

extension ___VARIABLE_productName:identifier___Presenter: ___VARIABLE_productName:identifier___Presenting {
    func presentNextStep(_ action: ___VARIABLE_productName:identifier___Action) {
        coordinator.perform(action)
    }
    
    func presentSomething() {
        display?.displaySomething()
    }
}
