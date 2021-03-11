//
//  
//  CharacterDetailsRootView.swift
//  CodeSample
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//
//

import UIKit

protocol CharacterDetailsRootViewDelegate: AnyObject {
    func didHappenSomething()
}

class CharacterDetailsRootView: ScreenView {
    weak var delegate: CharacterDetailsRootViewDelegate?
    
    private lazy var detailView = DetailView()
    
    override func buildScreen() {
        super.buildScreen()
        render(.contentView(detailView))
    }
    
    func layout(_ display: Display<CharacterScreenData>) {
        guard let data = display.value else { return }
        detailView.render(data.rows)
        let episodesView = EpisodesView()
        detailView.addRow(episodesView, inset: .zero)
        episodesView.layout(data.episodes)
    }
}
