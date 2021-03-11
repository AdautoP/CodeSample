//
//  ___FILEHEADER___
//

import UIKit

protocol ___VARIABLE_productName:identifier___Displayable: AnyObject {
    func displaySomething()
}

class ___VARIABLE_productName:identifier___ViewController: BaseViewController<___VARIABLE_productName:identifier___Interacting, ___VARIABLE_productName:identifier___RootView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.doSomething()
        rootView.delegate = self
    }
}

extension ___VARIABLE_productName:identifier___ViewController: ___VARIABLE_productName:identifier___Displayable {
    func displaySomething() {
        rootView.setupView()
    }
}

extension ___VARIABLE_productName:identifier___ViewController: ___VARIABLE_productName:identifier___RootViewDelegate {
    func didHappenSomething() {
        // ai chama outra acao do interactor que eu nao vou criar pq nao sou puta vcs entenderam
    }
}
