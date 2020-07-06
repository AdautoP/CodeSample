//
//  ImageHeaderView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import UIKit

public class ImageHeaderView: BaseView {
    
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
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(blurredBackgroundImageView)
        addSubview(imageView)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        blurView.edgesToSuperview()
        blurredBackgroundImageView.edgesToSuperview(excluding: .bottom)

        imageView.leftToSuperview(offset: 24)
        imageView.topToSuperview(self.centerYAnchor)
        imageView.widthToHeight(of: imageView)
        imageView.centerY(to: blurredBackgroundImageView, blurredBackgroundImageView.bottomAnchor)
        imageView.bottomToSuperview()
    }
    
    public func layout(_ imageUrl: String) {
        imageView.image(from: imageUrl)
        blurredBackgroundImageView.image(from: imageUrl)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
}
