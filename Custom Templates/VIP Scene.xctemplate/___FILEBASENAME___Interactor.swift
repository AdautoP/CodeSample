//
//  ___FILEHEADER___
//

import Foundation

protocol ___VARIABLE_productName:identifier___Interacting {
    func doSomething()
}

class ___VARIABLE_productName:identifier___Interactor {
    private let presenter: ___VARIABLE_productName:identifier___Presenting
    private let service: ___VARIABLE_productName:identifier___Servicing
    
    init(presenter: ___VARIABLE_productName:identifier___Presenting, service: ___VARIABLE_productName:identifier___Servicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension ___VARIABLE_productName:identifier___Interactor: ___VARIABLE_productName:identifier___Interacting {
    func doSomething() {
        presenter.presentSomething()
    }
}
