//
//  ImageHeaderView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import UIKit

class ImageHeaderView: BaseView {
    
    private let imageView = BaseImageView() >> {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.setCompressionResistance(.init(rawValue: 249), for: .vertical)
        $0.setCompressionResistance(.init(rawValue: 249), for: .horizontal)
    }
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    lazy var blurredBackgroundImageView = BaseImageView() >> {
        $0.addSubview(blurView)
        $0.contentMode = .scaleToFill
        $0.setCompressionResistance(.init(rawValue: 249), for: .vertical)
        $0.setCompressionResistance(.init(rawValue: 249), for: .horizontal)
    }
    
    private let titleLabel = UILabel() >> {
        $0.font = .appFont(size: 20, weight: .bold)
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    private let statusView = StatusView()
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(blurredBackgroundImageView)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(statusView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        blurView.edgesToSuperview()
        blurredBackgroundImageView.edgesToSuperview(excluding: .bottom)
        blurredBackgroundImageView.bottom(to: imageView, imageView.centerYAnchor)

        imageView.leftToSuperview(offset: 24)
        imageView.widthToHeight(of: imageView)
        imageView.bottom(to: self, offset: -24, relation: .equalOrLess)
        
        titleLabel.topToBottom(of: blurredBackgroundImageView, offset: 24)
        titleLabel.leftToRight(of: imageView, offset: 24)
        titleLabel.rightToSuperview(offset: -24)
        
        statusView.topToBottom(of: titleLabel)
        statusView.leftToRight(of: imageView, offset: 24)
        statusView.bottomToSuperview(offset: -24)
        
    }
    
    func layout(_ character: Character) {
        imageView.image(from: character.image)
        blurredBackgroundImageView.image(from: character.image)
        titleLabel.text = character.name
        statusView.layout(character.status, species: character.species, style: .header)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
}
