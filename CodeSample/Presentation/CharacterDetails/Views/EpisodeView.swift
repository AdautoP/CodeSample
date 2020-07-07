//
//  EpisodeView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import UIKit

class EpisodeView: BaseView {
    
    private let nameLabel = UILabel() >> {
        $0.textAlignment = .left
        $0.font = .appFont(size: 20, weight: .bold)
        $0.textColor = AppColors.Grays.lightGray
        $0.numberOfLines = 0
        $0.setCompressionResistance(.init(rawValue: 249), for: .vertical)
    }
    
    private let seasonLabel = UILabel() >> {
        $0.textAlignment = .left
        $0.font = .appFont(size: 20, weight: .bold)
        $0.textColor = AppColors.Grays.black
        $0.numberOfLines = 0
        $0.setCompressionResistance(.defaultHigh, for: .vertical)
    }
    
    override init() {
        super.init()
        backgroundColor = AppColors.Interface.yellow
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(nameLabel)
        addSubview(seasonLabel)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        seasonLabel.edgesToSuperview(excluding: .bottom, insets: .uniform(16))
        
        nameLabel.edgesToSuperview(excluding: .top, insets: .uniform(16))
        nameLabel.topToBottom(of: seasonLabel, offset: 16)
    }
    
    func layout(_ episode: Episode) {
        nameLabel.text = episode.name
        seasonLabel.text = episode.seasonName
    }
}
