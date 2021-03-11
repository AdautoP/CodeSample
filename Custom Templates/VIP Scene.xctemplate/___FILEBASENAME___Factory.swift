//
//  ___FILEHEADER___
//

import Foundation

enum ___VARIABLE_productName:identifier___Factory {
    static func make() -> ___VARIABLE_productName:identifier___ViewController {
        let coordinator = ___VARIABLE_productName:identifier___Coordinator()
        let presenter = ___VARIABLE_productName:identifier___Presenter(coordinator: coordinator)
        let service = ___VARIABLE_productName:identifier___Service()
        let interactor = ___VARIABLE_productName:identifier___Interactor(presenter: presenter, service: service)
        let controller = ___VARIABLE_productName:identifier___ViewController(interactor: interactor)
        
        presenter.display = controller
        
        return controller
    }
}
