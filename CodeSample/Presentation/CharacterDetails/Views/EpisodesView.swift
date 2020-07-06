//
//  EpisodesView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import AloeStackView
import UIKit

class EpisodesView: BaseView {
    
    var episodesViews = [EpisodeView]()
    
    private let nameLabel = UILabel() >> {
        $0.font = .appFont(size: 20, weight: .bold)
        $0.textColor = AppColors.Grays.black
        $0.text = "Episodes"
    }
    
    private let stackView = AloeStackView() >> {
        $0.axis = .horizontal
        $0.hidesSeparatorsByDefault = true
        $0.rowInset = .init(top: 24, left: 0, bottom: 24, right: 20)
        $0.backgroundColor = AppColors.Grays.lightGray
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(nameLabel)
        addSubview(stackView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        nameLabel.edgesToSuperview(excluding: .bottom, insets: .horizontal(24))
        
        stackView.topToBottom(of: nameLabel)
        stackView.edgesToSuperview(excluding: .top)
    }
    
    func layout(_ episodes: [Episode]) {
        episodesViews = episodes.map { episode in
            EpisodeView() >> {
                $0.layout(episode)
                $0.height(200)
                $0.width(150)
            }
        }
        
        episodesViews.enumerated().forEach {
            stackView.addRow($0.element)
            if $0.offset == 0 {
                stackView.setInset(forRow: $0.element, inset: .init(top: 24, left: 24, bottom: 24, right: 20))
            }
        }
    }
}
