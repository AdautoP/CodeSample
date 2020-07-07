//
//  EpisodeView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import UIKit

class EpisodeView: BaseView {
    
    private let shadowView = BaseView() >> {
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 16
        $0.layer.shadowRadius = 6
        $0.layer.shadowOffset = CGSize(width: -2, height: 2)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowColor = AppColors.Grays.darkerGray.cgColor
        $0.backgroundColor = AppColors.Interface.orange
    }
    
    private let nameLabel = BaseLabel() >> {
        $0.textAlignment = .left
        $0.font = .appFont(size: 16, weight: .bold)
        $0.textColor = AppColors.Grays.lightGray
        $0.numberOfLines = 0
        $0.setCompressionResistance(.init(rawValue: 249), for: .vertical)
        $0.contentMode = .bottom
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
        clipsToBounds = true
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(shadowView)
        shadowView.addSubview(nameLabel)
        shadowView.addSubview(seasonLabel)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        shadowView.edgesToSuperview(insets: .init(top: 24, left: 10, bottom: 24, right: 10))
        
        seasonLabel.edgesToSuperview(excluding: .bottom, insets: .uniform(16))
        
        nameLabel.edgesToSuperview(excluding: .top, insets: .uniform(16))
        nameLabel.topToBottom(of: seasonLabel, offset: 16)
    }
    
    func layout(_ episode: Episode) {
        nameLabel.text = episode.name
        seasonLabel.text = episode.seasonName
    }
}
