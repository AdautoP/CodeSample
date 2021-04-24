//
//  CharacterDetailsRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import AloeStackView
import UIKit

class CharacterDetailsRootView: ScreenView {
    
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
