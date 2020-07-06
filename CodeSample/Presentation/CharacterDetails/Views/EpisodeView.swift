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
        $0.font = .appFont(size: 16, weight: .bold)
        $0.textColor = AppColors.Grays.lightGray
        $0.numberOfLines = 0
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    override init() {
        super.init()
        backgroundColor = AppColors.Interface.yellow
        layer.cornerRadius = 16
        clipsToBounds = true
        setHugging(.defaultHigh, for: .vertical)
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(nameLabel)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        nameLabel.edgesToSuperview(insets: .uniform(8))
    }
    
    func layout(_ episode: Episode) {
        nameLabel.text = episode.name
    }
}
