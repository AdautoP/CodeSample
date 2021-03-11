//
//  
//  CharacterDetailsViewController.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import UIKit

struct CharacterScreenData {
    var rows: [DetailRowType]
    var episodes: [Episode]
}

protocol CharacterDetailsDisplayable: AnyObject {
    func displayCharacterScreenData(_ data: Display<CharacterScreenData>)
}

class CharacterDetailsViewController: BaseController<CharacterDetailsInteracting, CharacterDetailsRootView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadCharacters()
        rootView.delegate = self
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.layoutSubviews()
    }
}

extension CharacterDetailsViewController: CharacterDetailsDisplayable {    
    func displayCharacterScreenData(_ data: Display<CharacterScreenData>) {
        layout(data)
        rootView.layout(data)
    }
}

extension CharacterDetailsViewController: CharacterDetailsRootViewDelegate {
    func didHappenSomething() {
        // ai chama outra acao do interactor que eu nao vou criar pq nao sou puta vcs entenderam
    }
}
